<?php
$db = mysqli_connect('localhost','root','mark911028','pet'); 

if(!$db){
    echo "失敗連線資料庫";
}
$name = $_POST['name'];
$gender = $_POST['gender'];
$gmail = $_POST['gmail'];
$password = $_POST['password'];
$username = $_POST['username'];

$sql = "INSERT INTO Users (name,gender,gmail,username, password) VALUES ('".$name."','".$gender."','".$gmail."','".$username."', '".$password."')";
$query = mysqli_query($db,$sql);


 if($query){
    echo json_encode("success");
 }
else{
    echo json_encode("error");
}

?>