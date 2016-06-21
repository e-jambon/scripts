#!/bin/bash
dialog --checklist "Choose OS:" 15 40 5 \
  1 Linux off \
  2 Solaris on \
  3 'HP UX' off \
  4 AIX off


 echo "Il y a une solution aussi pour faire un dialogue fenêtré (graphique)"

gdialog --checklist "Choose OS:" 15 40 5 \
  1 Linux off \
  2 Solaris on \
  3 'HP UX' off \
  4 AIX off
