ORG 000H
MOV DPTR,#LUT // moves the addres of LUT to DPTR
MOV P1,#00000000B // Sets P1 as an output port
MOV P0,#00000000B // Sets P0 as an output port
MAIN: MOV R6,#14D
 SETB P3.5
 MOV TMOD,#01100001B // Sets Timer1 as Mode2 counter & Timer0 as 
Mode1 timer
 MOV TL1,#00000000B //loads initial value to TL1
 MOV TH1,#00000000B //loads initial value to TH1
 SETB TR1 // starts timer(counter) 1
BACK: MOV TH0,#00000000B //loads initial value to TH0
 MOV TL0,#00000000B //loads initial value to TL0
 SETB TR0 //starts timer 0
HERE: JNB TF0,HERE // checks for Timer 0 roll over
 CLR TR0 // stops Timer0
16
 CLR TF0 // clears Timer Flag 0
 DJNZ R6,BACK
 CLR TR1 // stops Timer(counter)1
 CLR TF0 // clears Timer Flag 0
 CLR TF1 // clears Timer Flag 1
 ACALL DLOOP // Calls subroutine DLOOP for displaying the count
 SJMP MAIN // jumps back to the main loop
DLOOP: MOV R5,#100D
BACK1: MOV A,TL1 // loads the current count to the accumulator
 MOV B,#100D
 DIV AB // isolates the first digit of the count
 SETB P1.0
 ACALL DISPLAY // converts the 1st digit to 7 seg pattern
 MOV P0,A // puts the pattern to Port 0
 ACALL DELAY // 1mS delay
 ACALL DELAY
 MOV A,B
 MOV B,#10D
 DIV AB // isolates the secong digit of the count
 CLR P1.0
 SETB P1.1
 ACALL DISPLAY // converts the 2nd digit to 7 seg pattern
 MOV P0,A
 ACALL DELAY
 ACALL DELAY
 MOV A,B // moves the last digit of the count to accumulator
 CLR P1.1
17
 SETB P1.2
 ACALL DISPLAY // converts the 3rd digit to 7 seg pattern
 MOV P0,A
 ACALL DELAY
 ACALL DELAY
 CLR P1.2
 DJNZ R5,BACK1 // repeats the subroutine DLOOP 100 times
 RET
DELAY: MOV R7,#250D // 1mS delay
DEL1: DJNZ R7,DEL1
 RET
DISPLAY: MOVC A,@A+DPTR // gets 7 seg digit drive pattern for current 
 CPL A 
 RET
LUT: DB 3FH // Look up table (LUT) starts here
 DB 06H
 DB 5BH
 DB 4FH
 DB 66H
 DB 6DH
 DB 7DH
 DB 07H
 DB 7FH
 DB 6FH
END
