
<html>
<head>
<title>Thermal sensor</title>
<meta http-equiv="Refresh" content="<?=$delay?>" />
<link rel="stylesheet" type="text/css" href="style.css">
<?php
header("Content-Type: text/html; charset=utf-8");
header('Refresh: 30; url=' .$_SERVER['PHP_SELF']);
?>
</head>
<body>

<div>
    <form action="" method="post">
    <input type="submit" name="all_on" value="all_on">
    <input type="submit" name="all_off" value="all_off">
    </form>

<?php
if ($_POST["all_on"]) {
#$c=shell_exec("echo 0 > /sys/class/gpio/gpio22/value");
$c=exec('/bin/bash /root/script/relay.sh on all');

echo "PRESSED ON";
echo $c;
}

if ($_POST["all_off"]) {
$b=exec('/bin/bash /root/script/relay.sh off all');
echo "PRESSED OFF";
echo $b;
}

#var_dump($_POST);
#var_dump($_SERVER);
?>

</div>

<div id="div2">
<?php
    // database credentials
    $db_host = 'localhost';
    $db_name = 'sensor_db';
    $db_username = 'pi';
    $db_password = 'r@spberry0';
    $db_table_to_show = 'sensor001';

    // connect to mysql
    $connect_to_db = mysql_connect($db_host, $db_username, $db_password)
    or die("Could not connect: " . mysql_error());

    // connect to database
    mysql_select_db($db_name, $connect_to_db)
    or die("Could not select DB: " . mysql_error());

    mysql_query('SET NAMES utf8 COLLATE utf8_unicode_ci');

    // output only last 101 values
    $qr_result = mysql_query("select * from $db_table_to_show ORDER BY datetime DESC")
    or die(mysql_error());

  //
  echo '<table border="1">';
  echo '<thead>';
  echo '<tr>';
  echo '<th> ID </th>';
  echo '<th> Place </th>';
  echo '<th> Temp </th>';
  echo '<th> Model </th>';
  echo '<th> Date </th>';
  echo '<th> PC name </th>';
  echo '<th> Additional </th>';
  echo '</tr>';
  echo '</thead>';
  echo '<tbody>';

  //
  while($data = mysql_fetch_array($qr_result)){
    echo '<tr>';
    echo '<td>' . $data['id'] . '</td>';
    echo '<td>' . $data['place'] . '</td>';
    echo '<td>' . '<div id="text-center">' . $data['sensdata'] . '</div>'.'</td>';
    echo '<td>' . '<div id="text-center">' . $data['modelsens'] . '</td>';
    echo '<td>' . $data['datetime'] . '</td>';
    echo '<td>' . $data['pcname'] . '</td>';
    echo '<td>' . $data['other'] . '</td>';
    echo '</tr>';
  }

    echo '</tbody>';
  echo '</table>';
    mysql_close($connect_to_db);
?>
</div>

</body>
</html>
