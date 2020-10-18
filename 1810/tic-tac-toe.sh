#!/bin/bash

BOARD=('0' '0' '0' '0' '0' '0' '0' '0' '0');
PLAYER=1

function printBoard {
	clear
	echo "${BOARD[0]} | ${BOARD[1]} | ${BOARD[2]}"
	echo "${BOARD[3]} | ${BOARD[4]} | ${BOARD[5]}"
	echo "${BOARD[6]} | ${BOARD[7]} | ${BOARD[8]}"
}

function changePlayer {
	if [ $PLAYER -eq 1 ]
	then
		PLAYER=2
	else
		PLAYER=1
	fi
}

function checkIfFree {
	if [ ${BOARD[$1]} = 0 ]
	then
		return 0;
	else
		return 1;
	fi
}

function readInput {
	echo 'Gracz ' ${PLAYER} ' wybiera pole:'
	read CHOICE

	if [ $CHOICE -ge 0 ] && [ $CHOICE -le 8 ] && checkIfFree $CHOICE
	then
		BOARD[CHOICE]=$PLAYER
		changePlayer
	fi
}

function checkSingleField {
	if [ ${BOARD[$1]} = $2 ]
	then
		return 0;
	else
		return 1;
	fi
}

function checkTriple {
	# $1 - playerNo, $2 - field 1, $3 - field 2, $4 - field 3
	if checkSingleField $2 $1 &&  
	   checkSingleField $3 $1 &&
	   checkSingleField $4 $1
	then
		return 0;
	fi
	return 1
}

function playerWon {
	if checkTriple $1 0 1 2 ||
	   checkTriple $1 3 4 5 ||
	   checkTriple $1 6 7 8 ||
	   checkTriple $1 0 3 6 ||
	   checkTriple $1 1 4 7 ||
	   checkTriple $1 2 4 5 ||
	   checkTriple $1 0 4 8 ||
	   checkTriple $1 2 4 6
	then 
		return 0
	fi
	return 1
}

function noOneWon {
	if playerWon 1 || playerWon 2
	then
		return 1;
	fi
	return 0;
}

while noOneWon
do
	printBoard
	readInput
done

printBoard
changePlayer
echo "Wygral gracz " $PLAYER

