#!/usr/bin/env bash


BIN=/srv/aptly/gui
source ${BIN}/vars.conf

list=(
        'Publish-Snapshots         Erstellt einen neuen Publish' \
        'Update-Publish            Updated alle Publishes auf einen neuen Snapshot' \
        'Update-Mirrors            Updated alle Mirrors' \
        'Create-Snapshots          Erstellet von allen Mirrors einen Snapshot' \
        'Delete-Snapshots          Löscht alte Snapshots' \
        'Create-Mirror             Erstellt einen neuen Mirror' \
) # my list

declare -a dia=()                                 # dialog array

for index in "${!list[@]}"; do # for each index in the list
  dia+=("$index" "${list[index]}")
done

while true ; do

choice=$(
  dialog --backtitle "Aptly Gui" --menu "Main Menu" 0 0 0 "${dia[@]}" \
    3>&1 1>&2 2>&3 3>&- # Swap stdout with stderr to capture returned dialog text
)
dialog_rc=$? # Save the dialog return code

clear # restore terminal background and clear

if [ "$dialog_rc" == "1" ]; then exit 0; fi

case $choice in
 # 1) echo ${SCRIPTS}/show-info.sh;;
  0) ${SCRIPTS}/publish-snapshot.sh;;
  1) ${SCRIPTS}/update-publish.sh;;
  2) ${SCRIPTS}/update-mirror.sh;;
  3) ${SCRIPTS}/create-snapshot.sh;;
  4) ${SCRIPTS}/delete-old-snapshots.py;;
  5) ${SCRIPTS}/create-mirror.sh;;
  *) continue ;;
esac

done
