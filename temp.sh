#! /bin/bash
sens01="28-80000001603c"
TemperatureFull=$(tail -c 6 /sys/bus/w1/devices/28-80000001603c/w1_slave)

TemperatureC=$(echo "scale=1; $TemperatureFull*0.001" | bc -l);
TempC=$(echo $TemperatureC | cut -c 1-4);

echo $TempC