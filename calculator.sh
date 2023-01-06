#!/bin/bash

######################################################
## This is a Calculator script which runs as normal calculator with a Textbased User Interface (TUI)
## This script was done by:
##	- Mohamed Ali Hassan
##	- Mohamed Ahmed Mkawy
## 	- Abdullah Salaheldien Mohamed
##	- Esraa Salah Sakr	
#####################################################

#Selecting Colors for the style
export NEWT_COLORS='
root=black,gray
title=white,black
window=white,black
border=white,black
shadow=black,gray
listbox=white,black
actsellistbox=black,white
actlistbox=white,gray
textbox=white,black
button=white,gray
compactbutton=white,black
checkbox=white,black
actcheckbox=lightgray,gray
#acttextbox=white,black
#actbutton=black,black
#label=white,black
#textbox=black,black
#acttextbox=black,black
#disentry=gray,lightgray
'
#################################
###### Main Page Section  ######
################################
_MAIN (){

page1_op=$(
whiptail --title "Calculator" --menu "" 25 50 3 --cancel-button "Exit" --ok-button "Enter" --notags\
        "1)" "Start The Calculator"\
        "2)" "Documentation"\
        "3)" "Team Members" 3>&1 1>&2 2>&3
)
EX=$?
if [ $EX = 1 ]
then
        exit
fi

case $page1_op in
        "1)")
                _CALC
                ;;
        "2)")
		_DOC
                ;;
        "3)")
		_TEAM
                ;;
esac
}
########################################
###### Documentation Page Section ######
########################################
_DOC () {
whiptail --title "Documentation" --msgbox \
'
This project is a calculator done by using bash scripting language and without using any calculating commands
The Main Page contains:
1-Documntation: description of the project and its features
2-Team members: name of the team members who did this project
3-The Calculator which contains:
   1.Standerd: is for the normal arthmetic operations which contatins:
	1-Clear: clears the currently displayed value on the screen
	2-Add(+): adds the entered number to the currently displayed value on the screen
	3-Sub(-): subtracts the entered number from the currently displayed value
	4-Multiply(*): multiplys the currently displayed value with the entered number 
	5-Division(/): divisions the currently displayed value by the entered number 
	6-Modulus(%): displays the remainder of divisioning the currently displayed value by the entered number 
	7-Power(^): displays the currently displayed number to the power of the entered number
	8-Factorial(!): displays the factorial of the currently displayed number
	9- -/+: converts the number currently displayed from negative to positive and vice versa
   2.Programmer: is for the higher level operations which contains:
	1-Clear: clears the currently displayed value on the screen
	2-Enter: takes number of any type(Hexadecimal,Decimal,Octal,Binary) and convert it to the other 3 types 
	3-And: takes number of any type(Hexadecimal,Decimal,Octal,Binary) then AND it with the currently displayed values
	4-OR: takes number of any type(Hexadecimal,Decimal,Octal,Binary) then OR it with the currently displayed values
	5-NOT: display the NOT of the currently displayed values
	6-NAND: takes number of any type(Hexadecimal,Decimal,Octal,Binary) then NAND it with the currently displayed value
	7-NOR: takes number of any type(Hexadecimal,Decimal,Octal,Binary) then NOR it with the currently displayed value
	8-XOR: takes number of any type(Hexadecimal,Decimal,Octal,Binary) then XOR it with the currently displayed value
	9-Shift Right(>>): shift the currently displayed number by the entered number
	10-Shift Left(<<): shift the currently displayed number by the entered number
' 25 130 --scrolltext --ok-button "back"
EX=$?
if [ $EX = 0 ]
then
        _MAIN
fi
}

########################################
###### Team Members Page Section ######
########################################
_TEAM () {
whiptail --title "Team Members" --msgbox \
'
This is a bash scripting project made in ITI "System Administration Track Aswan" by:
	- Mohamed Ali Hassan
	- Mohamed Ahmed Mkawy
	- Abdullah Salaheldien Mohamed
	- Esraa Salah Sakr

Presented to Eng. Karim Abd elhamid
' 25 50 --ok-button "back"
EX=$?
if [ $EX = 0 ]
then
        _MAIN
fi
}

#######################################
####### Calculator Page Section #######
#######################################
_CALC (){

page1_op=$(
whiptail --title "Calculator" --menu "" 25 50 3 --cancel-button "back" --ok-button "Enter"\
        "1)" "Standerd"\
        "2)" "Programmer" 3>&1 1>&2 2>&3
)
EX=$?
if [ $EX = 1 ]
then
        _MAIN
fi

case $page1_op in
        "1)")
                _STANDER "0" ""
                ;;
        "2)")
		_PROGRAMMER "0" ""
                ;;
esac
}

##################################
###### Stander Page Section ######
##################################
_STANDER () {

if [ $1 -gt 1000000000000000000 ] || [ $1 -lt -1000000000000000000 ]
then 
	whiptail --title '!ERROR!' --msgbox "Value out of limit (10^18)" 10 50
	_STANDER $CURRENT_NUMBER ""
fi

CURRENT_NUMBER=$1
LINE=$2

STAND_OP=$(
whiptail --title "Stander Operations"  --menu " $LINE \n Result ==> $CURRENT_NUMBER " 25 50 9 --cancel-button "back" --ok-button "Enter"\
        "1)" 'Clear'\
        "2)" 'Add(+)'\
        "3)" 'Sub(-)'\
        "4)" 'Multiply(*)'\
        "5)" 'Division(/)'\
        "6)" 'Modulus(%)'\
        "7)" 'Power(^)'\
        "8)" 'Factorial(!)'\
        "9)" ' -/+' 3>&2 2>&1 1>&3
)
EX=$?
if [ $EX = 1 ]
then
        _CALC
fi
case $STAND_OP in
        "1)")
                _CLEAR_STANDER

                ;;
        "2)")
                _ADD
                ;;
        "3)")
                _SUB
                ;;
        "4)")
                _MULTIPLY
                ;;
        "5)")
                _DIV
                ;;
        "6)")
                _MOD
                ;;
        "7)")
                _POWER
                ;;
        "8)")
                _FACTORIAL
                ;;
        "9)")
                _NP
                ;;
esac
}


_CLEAR_STANDER (){
        _STANDER "0" ""
}


_ADD (){
        INPUT_NUMBER=$(whiptail --title "Add" --inputbox "Enter number" 25 50 "" --ok-button "Enter"\
                --cancel-button "back"  3>&1 1>&2 2>&3)
        EX=$?
        if [ $EX = 1 ]
        then
                _STANDER $CURRENT_NUMBER "$LINE"
        else
                #Checking if the entered value is number
                if [[ $INPUT_NUMBER =~ ^[-0-9][0-9]*$ ]]
                then
                        NEW_NUMBER=$(($CURRENT_NUMBER + $INPUT_NUMBER))
                        _STANDER $NEW_NUMBER "$CURRENT_NUMBER + $INPUT_NUMBER"
                else
                        whiptail --title '!ERROR!' --msgbox "Entered Value Must be a Positive Number" 10 50
                        _ADD
                fi
        fi
}


_SUB (){
        INPUT_NUMBER=$(whiptail --title "Sub" --inputbox "Enter number" 25 50 "" --ok-button "Enter"\
                --cancel-button "back"  3>&1 1>&2 2>&3)
        EX=$?
        if  [ $EX = 1 ]
        then
                _STANDER $CURRENT_NUMBER "$LINE"
        else
                #Checking if the entered value is number
                if [[ $INPUT_NUMBER =~ ^[-0-9][0-9]*$ ]]
                then
                        NEW_NUMBER=$(($CURRENT_NUMBER - $INPUT_NUMBER))
                        _STANDER $NEW_NUMBER "$CURRENT_NUMBER - $INPUT_NUMBER "
                else
                        whiptail --title '!ERROR!' --msgbox "Entered Value Must be a Positive Number" 10 50
                        _SUB
                fi
        fi
}


_MULTIPLY (){
        INPUT_NUMBER=$(whiptail --title "Multiply" --inputbox "Enter number" 25 50 "" --ok-button "Enter"\
                --cancel-button "back"  3>&1 1>&2 2>&3)
        EX=$?
        if  [ $EX = 1 ]
        then
                _STANDER $CURRENT_NUMBER "$LINE"
        else
                #Checking if the entered value is number
                if [[ $INPUT_NUMBER =~ ^[-0-9][0-9]*$ ]]
                then
                        NEW_NUMBER=$(($CURRENT_NUMBER * $INPUT_NUMBER))
                        _STANDER $NEW_NUMBER "$CURRENT_NUMBER * $INPUT_NUMBER "
                else
                        whiptail --title '!ERROR!' --msgbox "Entered Value Must be a Positive Number" 10 50
                        _MULTIPLY
                fi
        fi
}


_DIV (){
        INPUT_NUMBER=$(whiptail --title "Division" --inputbox "Enter number" 25 50 "" --ok-button "Enter"\
                --cancel-button "back"  3>&1 1>&2 2>&3)

        EX=$?
        if [ $EX = 1 ]
        then
                _STANDER $CURRENT_NUMBER "$LINE"
        else
                #Checking if the entered value is number
                if [[ $INPUT_NUMBER =~ ^[-1-9][0-9]*$ ]]
                then
                        NEW_NUMBER=$(($CURRENT_NUMBER / $INPUT_NUMBER))
                        _STANDER $NEW_NUMBER "$CURRENT_NUMBER / $INPUT_NUMBER "
                else
                        whiptail --title '!ERROR!' --msgbox "Entered Value Must be a Positive Number" 10 50
                        _DIV
                fi
        fi
}

_MOD (){
        INPUT_NUMBER=$(whiptail --title "Modulus" --inputbox "Enter number" 25 50 "" --ok-button "Enter"\
                --cancel-button "back"  3>&1 1>&2 2>&3)
        EX=$?
        if [ $EX = 1 ]
        then
                _STANDER $CURRENT_NUMBER "$LINE"
        else
                #Checking if the entered value is number
                if [[ $INPUT_NUMBER =~ ^[-1-9][0-9]*$ ]]
                then
                        NEW_NUMBER=$(($CURRENT_NUMBER % $INPUT_NUMBER))
                       _STANDER $NEW_NUMBER "$CURRENT_NUMBER % $INPUT_NUMBER "
                else
                        whiptail --title '!ERROR!' --msgbox "Entered Value Must be a Positive Number" 10 50
                        _MOD
                fi
        fi

}


_POWER (){

        INPUT_NUMBER=$(whiptail --title "Power" --inputbox "Enter number" 25 50 "" --ok-button "Enter"\
                --cancel-button "back"  3>&1 1>&2 2>&3)
        EX=$?
        if [ $EX = 1 ]
        then
                _STANDER $CURRENT_NUMBER "$LINE"
        else
                #Checking if the entered value is number
                if [[ $INPUT_NUMBER =~ ^[0-9][0-9]*$ ]]
                then
                        NEW_NUMBER=$(($CURRENT_NUMBER ** $INPUT_NUMBER))
                        _STANDER $NEW_NUMBER "$CURRENT_NUMBER ^ $INPUT_NUMBER"
                else
                        whiptail --title '!ERROR!' --msgbox "Entered Value Must be a Positive Number" 10 50
                        _POWER
                fi
        fi
}


_FACTORIAL (){
	if [ $CURRENT_NUMBER -ge "26" ] || [ $CURRENT_NUMBER -lt "0" ]
	then
		whiptail --title '!ERROR!' --msgbox "The Current Value must be Positive and lower than 26" 10 50
		_STANDER $CURRENT_NUMBER ""
	fi
        COUNT=$CURRENT_NUMBER
        NEW_NUMBER=1
        while [ "$COUNT" -gt  "0" ]
        do
                NEW_NUMBER=$(($NEW_NUMBER * $COUNT))
                COUNT=$(($COUNT - 1))
        done
        _STANDER $NEW_NUMBER "Fact($CURRENT_NUMBER)"
}


_NP (){
        NEW_NUMBER=$((CURRENT_NUMBER * -1 ))
        _STANDER $NEW_NUMBER "$CURRENT_NUMBER -/+"
}

#####################################
###### Programmer Page Section ######
#####################################
_PROGRAMMER () {

##################Decimal to Hexdecimal############
_D2H () {
D=$1
NEGATIVE=0
#remove the negative sign 
if [[ $D =~ ^[-] ]]
then
NEGATIVE=1
D=${D:1:${#D}}
fi

TABLE=({{0..9},{A,B,C,D,E,F}})
hex=""
HEX=""
while [ $D -ne "0" ]
do
	hex+=${TABLE[$((D%16))]}
	D=$((D/16))
done
len=${#hex}

for((i=$len-1;i>=0;i--)); do HEX="$HEX${hex:$i:1}"; done

#put the negative sign back
if [[ $NEGATIVE -eq 1 ]]
then
HEX="-"$HEX
fi
}

##############Decimal to Octal##################
_D2O () {
D=$1
NEGATIVE=0
#remove the negative sign 
if [[ $D =~ ^[-] ]]
then
NEGATIVE=1
D=${D:1:${#D}}
fi	

octal=""
OCT=""
while [ $D -ne "0" ]
do
	octal+=$(($D%8)) 
	D=$((D/8))
done
len=${#octal}

for((i=$len-1;i>=0;i--)); do OCT="$OCT${octal:$i:1}"; done

#put the negative sign back
if [[ $NEGATIVE -eq 1 ]]
then
OCT="-"$OCT
fi
}

###############Decimal to Binary##################
_D2B () {
D=$1
NEGATIVE=0
#remove the negative sign 
if [[ $D =~ ^[-] ]]
then
NEGATIVE=1
D=${D:1:${#D}}
fi

binary=""
BIN=""
while [ $D -ne "0" ]
do
	binary+=$(($D%2))
	D=$((D/2))
done
len=${#binary}

for((i=$len-1;i>=0;i--)); do BIN="$BIN${binary:$i:1}"; done

#put the negative sign back
if [[ $NEGATIVE -eq 1 ]]
then
BIN="-"$BIN
fi
}


_D2H $1
_D2O $1
_D2B $1

if [[ $1 -eq "0" ]]
then
CURRENT_HEX="0"
CURRENT_DEC="0"
CURRENT_OCT="0"
CURRENT_BIN="0"
else
CURRENT_HEX=$HEX
CURRENT_DEC=$1
CURRENT_OCT=$OCT
CURRENT_BIN=$BIN
fi


LINE2=$2


PROGRAMMER_OP=$(
whiptail --title "Programmer Operations"  --menu "$LINE2\nHEX ==> $CURRENT_HEX\nDEC ==> $CURRENT_DEC\nOCT ==> $CURRENT_OCT\nBIN ==> $CURRENT_BIN" \
		25 50 10 --cancel-button "back" --ok-button "Enter"\
        "1)" "Clear"\
	"2)" "Enter"\
        "3)" "AND"\
        "4)" "OR"\
        "5)" "NOT"\
        "6)" "NAND"\
        "7)" "NOR"\
        "8)" "XOR"\
        "9)" "Shift Right [>>]"\
        "10)" "Shift Left [<<]" 3>&2 2>&1 1>&3
)
EX=$?
if [ $EX = 1 ]
then
        _CALC
fi
case $PROGRAMMER_OP in
        "1)")
		_CLEAR_PROGRAMMER
                ;;
        "2)")
		_ENTER "1"
                ;;
        "3)")
		_AND
                ;;
        "4)")
		_OR
                ;;
        "5)")
		_NOT
                ;;
        "6)")
		_NAND
                ;;
        "7)")
		_NOR
                ;;
        "8)")
		_XOR 
                ;;
        "9)")
		_SHIFT_RIGHT
                ;;
        "10)")
		_SHIFT_LEFT
                ;;
esac
}
_CLEAR_PROGRAMMER (){
        _PROGRAMMER "0"
}

#####################################
###### Enter Type Page Section ######
#####################################
_ENTER (){
OPTION=$1
ENTER_OP=$(
whiptail --title "Input Type"  --radiolist "Select Type of Input" 25 50 10 --cancel-button "back" --ok-button "Enter"\
        "1)" "HEX" ON\
	"2)" "DEC" OFF\
        "3)" "OCT" OFF\
        "4)" "BIN" OFF 3>&1 1>&2 2>&3
)
EX=$?
if [ $EX = 1 ]
then
        _PROGRAMMER $CURRENT_DEC
fi
case $ENTER_OP in
        "1)")
		_HEX
                ;;
        "2)")
        	_DEC
                ;;
        "3)")
        	_OCT
                ;;
        "4)")
		_BIN
                ;;
esac

if [ $OPTION = "1" ]
then
	_PROGRAMMER "$NEW_DEC" ""
fi

}


_HEX (){
        INPUT_NUMBER=$(whiptail --title "Hexdecimal" --inputbox "Enter HEX number:" 25 50 ""\
                --cancel-button "back" --ok-button "Enter"  3>&1 1>&2 2>&3)
        EX=$?
        if [ $EX = 1 ]
        then
                _ENTER "1"
        else
                #Checking if the entered value is Hexdecimal number
                if [[ $INPUT_NUMBER =~ ^[0-9A-Fa-f]{1,15}$ ]]
                then
			TYPE="HEX"
                        NEW_DEC=$((16#$INPUT_NUMBER))
                else
                        whiptail --title '!ERROR!' --msgbox "The Entered Value Must Hexdecimal" 10 50
                        _HEX
                fi
        fi
}

_DEC (){
        INPUT_NUMBER=$(whiptail --title "Decimal" --inputbox "Enter DEC number:" 25 50 ""\
                --cancel-button "back" --ok-button "Enter" 3>&1 1>&2 2>&3)
        EX=$?
        if [ $EX = 1 ]
        then
                _ENTER "1"
        else
                #Checking if the entered value is Decimal number
                if [[ $INPUT_NUMBER =~ ^[-0-9]{1,18}$ ]]
                then
			TYPE="DEC"
                        NEW_DEC=$(($INPUT_NUMBER))
                else
                        whiptail --title '!ERROR!' --msgbox "The Entered Value Must Decimal Within Limit" 10 50
                        _DEC
                fi
        fi
}

_OCT (){
        INPUT_NUMBER=$(whiptail --title "Octal" --inputbox "Enter OCT number:" 25 50 ""\
                --cancel-button "back" --ok-button "Enter" 3>&1 1>&2 2>&3)
        EX=$?
        if [ $EX = 1 ]
        then
                _ENTER "1"
        else
                #Checking if the entered value is Octal number
                if [[ $INPUT_NUMBER =~ ^[0-7]{1,20}$ ]]
                then
			TYPE="OCT"
                        NEW_DEC=$((8#$INPUT_NUMBER))
                else
                        whiptail --title '!ERROR!' --msgbox "The Entered Value Must Be Octal" 10 50
                        _OCT
                fi
        fi
}

_BIN (){
        INPUT_NUMBER=$(whiptail --title "Binary" --inputbox "Enter BIN number:" 25 50 ""\
                --cancel-button "back" --ok-button "Enter" 3>&1 1>&2 2>&3)
        EX=$?
        if [ $EX = 1 ]
        then	
                _ENTER "1"
        else
                #Checking if the entered value is Binary number
                if [[ $INPUT_NUMBER =~ ^[0-1]*$ ]]
                then
			TYPE="BIN"
                        NEW_DEC=$((2#$INPUT_NUMBER))
                else
                        whiptail --title '!ERROR!' --msgbox "The Entered Value Must Be Binary" 10 50
                        _BIN
                fi
        fi
}

########################################
###### Bitwise Operations Section ######
########################################
_AND () {
        if [[ $CURRENT_DEC =~ ^[-] ]]
        then
                whiptail --title '!ERROR!' --msgbox "Current Value Must be a Positive" 10 50
                _PROGRAMMER $CURRENT_DEC "$LINE2"
        fi
	_ENTER "0" 

	VALUE=$((CURRENT_DEC&NEW_DEC))
	#Display Programmer first Line as the last entered value
	_D2H $NEW_DEC
	NEW_HEX=$HEX
	_D2O $NEW_DEC
	NEW_OCT=$OCT
	_D2B $NEW_DEC
	NEW_BIN=$BIN

	_D2H $CURRENT_DEC
	_D2O $CURRENT_DEC
	_D2B $CURRENT_DEC

	if [ $TYPE = "HEX" ]
	then
	_PROGRAMMER "$VALUE" "HEX => $HEX AND $NEW_HEX <="
	elif [ $TYPE = "DEC" ]
	then
	_PROGRAMMER "$VALUE" "DEC => $CURRENT_DEC AND $NEW_DEC <="
	elif [ $TYPE = "OCT" ]
	then
	_PROGRAMMER "$VALUE" "OCT => $OCT AND $NEW_OCT <="
	else
	_PROGRAMMER "$VALUE" "BIN => $BIN AND $NEW_BIN <="
	fi

}

_OR () {
	if [[ $CURRENT_DEC =~ ^[-] ]]
	then
		whiptail --title '!ERROR!' --msgbox "The Current Value Must Be Positive" 10 50
		_PROGRAMMER $CURRENT_DEC $LINE2
	fi
	_ENTER "0" 

	VALUE=$((CURRENT_DEC|NEW_DEC))

	#Display Programmer first Line as the last entered value
	_D2H $NEW_DEC
	NEW_HEX=$HEX
	_D2O $NEW_DEC
	NEW_OCT=$OCT
	_D2B $NEW_DEC
	NEW_BIN=$BIN

	_D2H $CURRENT_DEC
	_D2O $CURRENT_DEC
	_D2B $CURRENT_DEC

	if [ $TYPE = "HEX" ]
	then
	_PROGRAMMER "$VALUE" "HEX => $HEX OR $NEW_HEX <="
	elif [ $TYPE = "DEC" ]
	then
	_PROGRAMMER "$VALUE" "DEC => $CURRENT_DEC OR $NEW_DEC <="
	elif [ $TYPE = "OCT" ]
	then
	_PROGRAMMER "$VALUE" "OCT => $OCT OR $NEW_OCT <="
	else
	_PROGRAMMER "$VALUE" "BIN => $BIN OR $NEW_BIN <="
	fi

}

_NOT () {
	VALUE=$((~CURRENT_DEC))

	#Display Programmer first Line as the last entered value

	_D2H $CURRENT_DEC
	_D2O $CURRENT_DEC
	_D2B $CURRENT_DEC

	if [ $TYPE = "HEX" ]
	then
	_PROGRAMMER "$VALUE" "HEX => NOT $HEX <="
	elif [ $TYPE = "DEC" ]
	then
	_PROGRAMMER "$VALUE" "DEC => NOT $CURRENT_DEC <="
	elif [ $TYPE = "OCT" ]
	then
	_PROGRAMMER "$VALUE" "OCT => NOT $OCT <="
	else
	_PROGRAMMER "$VALUE" "BIN => NOT $BIN <="
	fi
}

_NAND () {
	if [[ $CURRENT_DEC =~ ^[-] ]]
	then
		whiptail --title '!ERROR!' --msgbox "The Current Value Must Be Positive" 10 50
		_PROGRAMMER $CURRENT_DEC $LINE2
	fi
	_ENTER "0" 

	VALUE=$((~(CURRENT_DEC&NEW_DEC)))

	#Display Programmer first Line as the last entered value
	_D2H $NEW_DEC
	NEW_HEX=$HEX
	_D2O $NEW_DEC
	NEW_OCT=$OCT
	_D2B $NEW_DEC
	NEW_BIN=$BIN

	_D2H $CURRENT_DEC
	_D2O $CURRENT_DEC
	_D2B $CURRENT_DEC

	if [ $TYPE = "HEX" ]
	then
	_PROGRAMMER "$VALUE" "HEX => $HEX NAND $NEW_HEX <="
	elif [ $TYPE = "DEC" ]
	then
	_PROGRAMMER "$VALUE" "DEC => $CURRENT_DEC NAND $NEW_DEC <="
	elif [ $TYPE = "OCT" ]
	then
	_PROGRAMMER "$VALUE" "OCT => $OCT NAND $NEW_OCT <="
	else
	_PROGRAMMER "$VALUE" "BIN => $BIN NAND $NEW_BIN <="
	fi

}

_NOR () {
	if [[ $CURRENT_DEC =~ ^[-] ]]
	then
		whiptail --title '!ERROR!' --msgbox "The Current Value Must Be Positive" 10 50
		_PROGRAMMER $CURRENT_DEC $LINE2
	fi
	_ENTER "0" 

	VALUE=$((~(CURRENT_DEC|NEW_DEC)))

	#Display Programmer first Line as the last entered value
	_D2H $NEW_DEC
	NEW_HEX=$HEX
	_D2O $NEW_DEC
	NEW_OCT=$OCT
	_D2B $NEW_DEC
	NEW_BIN=$BIN

	_D2H $CURRENT_DEC
	_D2O $CURRENT_DEC
	_D2B $CURRENT_DEC

	if [ $TYPE = "HEX" ]
	then
	_PROGRAMMER "$VALUE" "HEX => $HEX NOR $NEW_HEX <="
	elif [ $TYPE = "DEC" ]
	then
	_PROGRAMMER "$VALUE" "DEC => $CURRENT_DEC NOR $NEW_DEC <="
	elif [ $TYPE = "OCT" ]
	then
	_PROGRAMMER "$VALUE" "OCT => $OCT NOR $NEW_OCT <="
	else
	_PROGRAMMER "$VALUE" "BIN => $BIN NOR $NEW_BIN <="
	fi

}

_XOR () {
	if [[ $CURRENT_DEC =~ ^[-] ]]
	then
		whiptail --title '!ERROR!' --msgbox "The Current Value Must Be Positive" 10 50
		_PROGRAMMER $CURRENT_DEC $LINE2
	fi
	_ENTER "0" 

	VALUE=$((CURRENT_DEC^NEW_DEC))

	#Display Programmer first Line as the last entered value
	_D2H $NEW_DEC
	NEW_HEX=$HEX
	_D2O $NEW_DEC
	NEW_OCT=$OCT
	_D2B $NEW_DEC
	NEW_BIN=$BIN

	_D2H $CURRENT_DEC
	_D2O $CURRENT_DEC
	_D2B $CURRENT_DEC

	if [ $TYPE = "HEX" ]
	then
	_PROGRAMMER "$VALUE" "HEX => $HEX XOR $NEW_HEX <="
	elif [ $TYPE = "DEC" ]
	then
	_PROGRAMMER "$VALUE" "DEC => $CURRENT_DEC XOR $NEW_DEC <="
	elif [ $TYPE = "OCT" ]
	then
	_PROGRAMMER "$VALUE" "OCT => $OCT XOR $NEW_OCT <="
	else
	_PROGRAMMER "$VALUE" "BIN => $BIN XOR $NEW_BIN <="
	fi

}

_SHIFT_RIGHT () {
	if [[ $CURRENT_DEC =~ ^[-] ]]
	then
		whiptail --title '!ERROR!' --msgbox "The Current Value Must Be Positive" 10 50
		_PROGRAMMER $CURRENT_DEC $LINE2
	fi
	_ENTER "0" 

	VALUE=$(($CURRENT_DEC>>$NEW_DEC))

	#Display Programmer first Line as the last entered value
	_D2H $NEW_DEC
	NEW_HEX=$HEX
	_D2O $NEW_DEC
	NEW_OCT=$OCT
	_D2B $NEW_DEC
	NEW_BIN=$BIN

	_D2H $CURRENT_DEC
	_D2O $CURRENT_DEC
	_D2B $CURRENT_DEC

	if [ $TYPE = "HEX" ]
	then
	_PROGRAMMER "$VALUE" "HEX => $HEX Rsh $NEW_HEX <="
	elif [ $TYPE = "DEC" ]
	then
	_PROGRAMMER "$VALUE" "DEC => $CURRENT_DEC Rsh $NEW_DEC <="
	elif [ $TYPE = "OCT" ]
	then
	_PROGRAMMER "$VALUE" "OCT => $OCT Rsh $NEW_OCT <="
	else
	_PROGRAMMER "$VALUE" "BIN => $BIN Rsh $NEW_BIN <="
	fi

}

_SHIFT_LEFT () {
	if [[ $CURRENT_DEC =~ ^[-] ]]
	then
		whiptail --title '!ERROR!' --msgbox "The Current Value Must Be Positive" 10 50
		_PROGRAMMER $CURRENT_DEC $LINE2
	fi
	_ENTER "0" 

	VALUE=$(($CURRENT_DEC<<$NEW_DEC))

	#Display Programmer first Line as the last entered value
	_D2H $NEW_DEC
	NEW_HEX=$HEX
	_D2O $NEW_DEC
	NEW_OCT=$OCT
	_D2B $NEW_DEC
	NEW_BIN=$BIN

	_D2H $CURRENT_DEC
	_D2O $CURRENT_DEC
	_D2B $CURRENT_DEC

	if [ $TYPE = "HEX" ]
	then
	_PROGRAMMER "$VALUE" "HEX => $HEX Lsh $NEW_HEX <="
	elif [ $TYPE = "DEC" ]
	then
	_PROGRAMMER "$VALUE" "DEC => $CURRENT_DEC Lsh $NEW_DEC <="
	elif [ $TYPE = "OCT" ]
	then
	_PROGRAMMER "$VALUE" "OCT => $OCT Lsh $NEW_OCT <="
	else
	_PROGRAMMER "$VALUE" "BIN => $BIN Lsh $NEW_BIN <="
	fi

}


###### Calling the Main Function to start the program ######
_MAIN
############################################################

