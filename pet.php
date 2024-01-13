<?php
$db = mysqli_connect('localhost','root','mark911028','pet'); 

if(!$db){
    echo "失敗連線資料庫";
}
$username = $_POST['username'];
$petname = $_POST['petname'];
$species = $_POST['species'];
$birthdate = $_POST['birthdate'];


$sql = "INSERT INTO pets (username,petname,species,birthdate) VALUES ('".$username."','".$petname."','".$species."','".$birthdate."')";
$query = mysqli_query($db,$sql);


 if($query){
    echo json_encode("success");
 }
else{
    echo json_encode("error");
}

?>