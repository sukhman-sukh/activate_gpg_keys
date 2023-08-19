#!/bin/bash

#sudo apt update
#sudo apt-get install gnupg
entry=-1
removeInput=00
keyInput=0
uid=""

signing() {
	echo $1
	local GPG_KEY_ID1="$1"
	git config --global user.signingkey $GPG_KEY_ID1
	git config --global commit.gpgsign true
	
	echo "========================================================\n\n"
	
	gpg --armor --export $GPG_KEY_ID1
	echo "\n\n========================================================"
	echo "Copy And Paste this Key in GitHub"

}

echo "Enter 0 to exit "
while [[ $entry -ne 0 ]]
do
echo "Enter 1 to generate new gpg key "
echo "Enter 2 to Remove Old GPG Key "

echo "Enter 3 to Select GPG Key And Make It Signing key "


echo "========================================="
echo "Currently you have these keys"
gpg --list-secret-keys
echo "========================================="

read entry
if [ $entry == 1 ]
then
	gpg --full-generate-key

	GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | cut -d'/' -f2 | tail -n 1)
    signing "$GPG_KEY_ID"

	
elif [ $entry == 2 ]
then
	echo "Enter UID / Secret_key :- "
	read uid
	gpg --delete-secret-key $uid 
	gpg --delete-key $uid

elif [ $entry == 3 ]
then
echo "enter the Secret key You Want To Sign With , Below"
	read GPG_KEY_ID
	signing "$GPG_KEY_ID"

elif [ $entry == 0 ]
then
echo "B-Byeee"
else
	echo "Wrong entry ! Try Again"
fi
done



