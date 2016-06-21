 #!/bin/bash

# Store menu options selected by the user
INPUT=/tmp/menu.sh.$$

# trap and delete temp files
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM


while :
do
  dialog --backtitle "M A I N - M E N U" --menu "Faites un choix :" 0 0 0\
    1 "Currently logged user"\
    2 "List of users currently loged"\
    3 "Present handling directory"\
    4 "Exit" 2>"${INPUT}"

  menuitems=$(<"${INPUT}")

    
  case $menuitems in
     1) text_to_display=$(who) ; dialog --infobox  "$text_to_display" 3 50 ; sleep 5;;
     2) dialog --infobox "choix 2" 3 50 ; sleep 5;;
     3) dialog --infobox "choix 3" 3 50 ; sleep 5;;
     4) dialog --infobox "Bye $USER" 3 50; sleep 5;
        exit 1;;
     *) echo "$menuitems is an invaild option. Please select option between 1-4 only";
        echo "Press [enter] key to continue. . .";
        read enterKey;;
  esac
done

# if temp files found, delete em

[ -f $INPUT ] && rm $INPUT
