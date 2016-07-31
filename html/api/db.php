<?php
$dbhost="localhost";
$dbuser="littlefine_tc01";
$dbpass="FmypDng7";
$dbname="littlefine_tc01";
$db = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass); 
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$db->query("SET NAMES 'utf8'");
?>