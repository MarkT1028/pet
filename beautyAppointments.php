<?php
$db = mysqli_connect('localhost','root','mark911028','pet'); 

if(!$db){
    echo "失敗連線資料庫";
}
$username  = $_POST['username'];
$petname   = $_POST['petname'];
$appointmentdate = $_POST['appointmentdate'];
$appointment_type = $_POST['appointment_type'];

$sql = "INSERT INTO appointments (username,petname,appointmentdate,appointment_type) VALUES ('".$username."','".$petname."','".$appointmentdate."','".$appointment_type."')";
$query = mysqli_query($db,$sql);


 if($query){
    echo json_encode("success");
 }
else{
    echo json_encode("error");
}

?>