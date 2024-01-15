#!/bin/awk -f
BEGIN {
  FS = "([ ]?:[ ]+)";
  print "DEVICE,SERIAL,BATTERY_LVL";
}
/^Device/ { current_dev=$2; }
/^\s+serial/{ serial[current_dev]=$2; }
/^\s+percentage/{ batteries[current_dev]=$2; }
END {
    for(device in batteries){
        print device "," serial[device] "," batteries[device];
    }
}
