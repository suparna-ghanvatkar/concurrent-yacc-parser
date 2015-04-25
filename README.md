# concurrent-yacc-parser
This is a program for concurrent yacc parser i.e. it does parsing concurrently using openmp.
A input file is parsed for doing calculations and these calculations are shown on output screen.

The operations supported are the four basic arithmetic operations.
All the three files need to be in the same folder.

The compilation and execution steps are as follows: 
<br/>$yacc -d yaccparser2.y
<br/>$lex lexinput.l
<br/>$gcc lex.yy.c y.tab.c -o yaccparser -fopenmp
<br/>$./yaccparser
