#!/bin/bash

#sudo apt update
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

echo "Enter 3 to Select GPG Key And Make It Signing key "

echo "========================================="
echo "Currently you have these keys"
#gpg --list-secret-keys
gpg --list-keys
echo "========================================="

read entry
if [ $entry == 1 ]
then
	gpg --gen-key
	
elif [ $entry == 2 ]
then
	echo "Enter 1 to Remove Old GPG Key using UID /Secret key "
	read removeInput
	if [ $removeInput == 1 ]
	then
		echo "Enter UID :- "
		read uid
		gpg --delete-secret-key $uid
		gpg --delete-key $uid
	
	else
		echo "Wrogn entry"
	fi

elif [ $entry == 3 ]
then
echo "enter the Secret key You Want To Sign With , Below"
	read GPG_KEY_ID
	git config --global user.signingkey $GPG_KEY_ID
	git config --global commit.gpgsign true
	
	echo "======================================================== \n \n"
	
	gpg --armor --export $GPG_KEY_ID
	echo "\n \n ========================================================"
	echo "Copy And Paste this Key in GitHub"
elif [ $entry == 0 ]
then
echo "B-Byeee"
else
	echo "Wrong entry ! Try Again"
fi
done
