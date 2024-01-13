<?php
$db = mysqli_connect('localhost', 'root', 'mark911028', 'pet');

if (!$db) {
    echo "失敗連線資料庫";
}

$owner = isset($_GET['owner']) ? $_GET['owner'] : '';

$sql = "SELECT Users.name AS owner_name, pets.petname AS pet_name
        FROM Users
        LEFT JOIN pets ON Users.username = pets.username
        WHERE Users.name LIKE '%$owner%'";

$query = mysqli_query($db, $sql);

if ($query) {
    $ownersAndPets = array();
    while ($row = mysqli_fetch_assoc($query)) {
        $ownerName = $row['owner_name'];
        $petName = $row['pet_name'];
        $ownersAndPets[] = array('owner_name' => $ownerName, 'pet_name' => $petName);
    }
    echo json_encode(array('ownersAndPets' => $ownersAndPets));
} else {
    echo json_encode("error");
}
?>
