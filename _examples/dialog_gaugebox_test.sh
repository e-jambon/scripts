#!/bin/bash
# Exemple pour faire une jauge d'avancement

(
c=10
while [ $c -ne 110 ]
  do
    echo $c | dialog --title "Un exemple de jauge" --gauge "Veuillez patienter ..." 10 60 0
    #c=$(($c + 10))   # Fonctionne avec sh et bash
    ((c+=10))		  # ne fonctionnerait pas avec sh, fonctionne avec bash
    sleep 1
  done
)
