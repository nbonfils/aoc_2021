variable horizontal
variable vertical
variable aim

: nextnum 0. bl word count >number 2drop drop ;

( PART 1 )
0 horizontal !
0 vertical !

: forward nextnum horizontal +! ;
: up nextnum negate vertical +! ;
: down nextnum vertical +! ;

include 02.txt
cr ." Part 1: " horizontal @ vertical @ * .

( PART 2 )
0 horizontal !
0 vertical !
0 aim !

: forward nextnum dup horizontal +! aim @ * vertical +! ;
: up nextnum negate aim +! ;
: down nextnum aim +! ;

include 02.txt
cr ." Part 2: " horizontal @ vertical @ * .
cr