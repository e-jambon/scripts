#!/bin/bash
dialog --title "Boite de dialogue de test" \
  --backtitle "Exampli inputbox" \
  --inputbox "Saisissez le nom de votre OS ici" 8 50


echo "avec gtk : "
gdialog --title "Boite de dialogue de test" \
    --backtitle "Exampli inputbox" \
    --inputbox "Saisissez le nom de votre OS ici" 8 50
