#!/bin/bash
set -x
echo -n "can you write device drivers? "
read answer
answer=`echo $answer | tr [a-z] [A-Z]`
if [ $answer = Y ]
then
    echo "Wow, you must bevery skilled"
else
    echo "Neither can I, I'm jsut an example shell script"
fi


