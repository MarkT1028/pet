<?php

$db = mysqli_connect('localhost', 'root', 'mark911028', 'pet');

if (!$db) {
    echo "失敗連線資料庫";
}

$username = $_POST['username'];
$petname = $_POST['petname'];
$diary_date = $_POST['diary_date'];
$health_type = $_POST['health_type'];
$life_type = $_POST['life_type'];

$sql = "INSERT INTO diary (username, petname, diary_date, health_type,life_type) VALUES ('$username', '$petname', '$diary_date', '$health_type','$life_type')";
$query = mysqli_query($db, $sql);

if ($query) {
    echo json_encode("success");
} else {
    echo json_encode("error");
}
?>
