#!/bin/bash

#sudo apt update
#gpg --armor --export $GPG_KEY_ID
#sudo apt-get install gnupg
entry=50
removeInput=0
keyInput=0
uid=""

echo "Enter 0 to exit "
while [[ $entry -ne 0 ]]
do
echo "Enter 1 to generate new gpg key "
echo "Enter 2 to Remove Old GPG Key "

echo "========================================="
echo "Currently you have these keys"
#gpg --list-secret-keys
gpg --list-keys
echo "========================================="

read entry
if [ $entry == 1 ]
then
	gpg --gen-key
	echo "enter the genetated key below"
	read GPG_KEY_ID
	git config --global user.signingkey $GPG_KEY_ID
	git config --global commit.gpgsign true
elif [ $entry == 2 ]
then
	echo "Enter 1 to Remove Old GPG Key using UID "
	echo "Enter 2 to Remove Old GPG Key using Secret key"
	read removeInput
	if [ $removeInput == 1 ]
	then
		echo "Enter UID :- "
		read uid
		gpg --delete-secret-key $uid
	
	elif [ $removeInput == 2 ]
	then
		echo "Enter Secret Key :- "
		read keyInput 
		gpg --delete-secret-key $keyInput
	else
		echo "Wrogn entry"
	fi

elif [ $entry == 0 ]
then
echo "B-Byeee"
else
	echo "Wrong entry ! Try Again"
fi
done
