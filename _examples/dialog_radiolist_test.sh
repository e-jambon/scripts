#!/bin/bash
dialog --backtitle "OS infomration" \
  --radiolist "Select OS:" 10 40 3 \
  1 'Linux 7.2' off \
  2 'Solaris 9' on \
  3 'HPUX 11i' off
