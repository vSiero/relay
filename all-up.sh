#!/bin/bash

echo 22 > /sys/class/gpio/export 2>&1
echo out > /sys/class/gpio/gpio22/direction 2>&1
echo 0 > /sys/class/gpio/gpio22/value 2>&1

echo 23 > /sys/class/gpio/export 2>&1
echo out > /sys/class/gpio/gpio23/direction 2>&1
echo 0 > /sys/class/gpio/gpio23/value 2>&1

echo 24 > /sys/class/gpio/export 2>&1
echo out > /sys/class/gpio/gpio24/direction 2>&1
echo 0 > /sys/class/gpio/gpio24/value 2>&1

echo 25 > /sys/class/gpio/export 2>&1
echo out > /sys/class/gpio/gpio25/direction 2>&1
echo 0 > /sys/class/gpio/gpio25/value 2>&1
