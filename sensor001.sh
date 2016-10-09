#! /bin/bash
sens01="28-80000001603c"
TemperatureFull=$(tail -c 6 /sys/bus/w1/devices/$sens01/w1_slave)

TemperatureC=$(echo "scale=1; $TemperatureFull*0.001" | bc -l);
TempC=$(echo $TemperatureC | cut -c 1-4);


if [ $(cat /sys/class/gpio/gpio22/value) = 0 ]; then r1=1; else r1=0; fi
if [ $(cat /sys/class/gpio/gpio23/value) = 0 ]; then r2=1; else r2=0; fi
if [ $(cat /sys/class/gpio/gpio24/value) = 0 ]; then r3=1; else r3=0; fi
if [ $(cat /sys/class/gpio/gpio25/value) = 0 ]; then r4=1; else r4=0; fi

# Database table structure
#
# id		int(30)
# place		varchar(50)
# sensdata	varchar(30)
# modelsens 	varchar(30)
# pcname	varchar(30)
# datetime	datetime
# other		varchar(50)

hostname=$(uname -n -r)

mysql -D sensor_db -u pi -pr@spberry0 << EOF 2>/dev/null
USE sensor_db;
SET NAMES utf8 COLLATE utf8_unicode_ci;
INSERT INTO sensor001 VALUES (NULL,'room1',$TempC,'$sens01','$hostname',NOW(),'$r1 $r2 $r3 $r4');
EOF
