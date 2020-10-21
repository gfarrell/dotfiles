#!/bin/awk -f
BEGIN {
  FS = "([ ]?:[ ])|([ ]=[ ])";
  print "INDEX,NICE_NAME,DEVICE,ACTIVE_PROFILE"
  count = 0;
}
/index/ { i=$2; indices[count++] = $2 }
/^\s+name:/ { names[i] = $2 }
/^\s+active profile:/ { profiles[i] = $2 }
/^\s+device\.description/ { nice[i] = $2 }
END {
  for (j=0; j<count; j++) {
    i=indices[j];
    print i "," nice[i] "," names[i] "," profiles[i]
  }
}
