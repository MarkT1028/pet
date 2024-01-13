<?php
$db = mysqli_connect('localhost','root','mark911028','pet'); 

if(!$db){
    echo "失敗連線資料庫";
}
$username = $_POST['username'];
$petname = $_POST['petname'];
$feed_time = $_POST['feed_time'];
$meal_type = $_POST['meal_type'];


$sql = "INSERT INTO feed (username,petname,feed_time,meal_type) VALUES ('".$username."','".$petname."','".$feed_time."','".$meal_type."')";
$query = mysqli_query($db,$sql);


 if($query){
    echo json_encode("success");
 }
else{
    echo json_encode("error");
}

?>