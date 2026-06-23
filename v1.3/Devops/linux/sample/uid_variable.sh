#!/bin/bash
root_uid=0
if [ "$root_ui" == "$UID" ]
then
    echo "You are root."
else
    echo "You are just an ordinary user."
fi

exit 0