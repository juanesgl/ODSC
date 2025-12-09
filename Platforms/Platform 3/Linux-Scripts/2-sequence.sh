#!/bin/bash
clear

line_count=$(wc -l < /etc/profile)
echo "The number of lines on /etc/profile is: $line_count"
