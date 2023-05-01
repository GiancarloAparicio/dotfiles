!#/bin/bash

######################################################################
# @author      : Giancarlo Aparicio
# @created     : mar 07 feb 2023 20:37:19 -05
#
# @description : Script que genera un caso practico para practicar Merge
######################################################################

rm -r ~/project-git

mkdir -p ~/project-git

cd ~/project-git

git init

for number in 1 2 3 4 5; do
    git commit -m "empty commit $number" --allow-empty
done

for number in 1 2 3 4 5; do
	touch $number.txt

	echo "First line $number" >$number.txt
	echo "-------------------------- line $number" >>$number.txt
	echo "  " >>$number.txt
	echo "  " >>$number.txt
	echo "  " >>$number.txt
	echo "Second line $number" >>$number.txt

done

git add .
git commit -m "Inicio"

git checkout -b dev

for number in 1 2 3 4 5; do
	echo "First line $number - dev" >$number.txt
	echo "-------------------------- line $number - dev" >>$number.txt
	echo "  " >>$number.txt
	echo "  " >>$number.txt
	echo "  " >>$number.txt
	echo "Second line $number - dev" >>$number.txt

done

git add .
git commit -m "Cambios dev"

git checkout master

for number in 1 2 3 4 5; do
	echo "First line $number - master" >$number.txt
	echo "----***********------------- line $number - master" >>$number.txt
	echo "  " >>$number.txt
	echo "  " >>$number.txt
	echo "  " >>$number.txt
	echo "Second line $number - master" >>$number.txt

done

git add .
git commit -m "Cambios master"

git merge dev
