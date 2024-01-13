<?php
$db = mysqli_connect('localhost','root','mark911028','pet'); 

if(!$db){
    echo "失敗連線資料庫";
}
// else{
//     echo "成功連線資料庫";
// }


$username = $_POST['username'];
$password = $_POST['password'];


$sql = "SELECT * FROM Users WHERE username = '".$username."' AND password='".$password."' ";
$result = mysqli_query($db,$sql);
$coumt = mysqli_num_rows($result);

 if($coumt >= 1){
    echo json_encode("success");
 }
else{
    echo json_encode("error");
}
?>