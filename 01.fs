6 constant bufsize
create buf bufsize 2 + allot
s" 01.txt" r/o open-file throw value fd-in

: part1 ( -- n)
-1 0
begin
	buf bufsize fd-in read-line throw
while
	buf swap 0. 2swap >number 2drop drop dup
	rot > negate rot + swap
repeat 2drop ;

: readnum ( -- num count buf-flag )
	buf bufsize fd-in read-line throw dup if
		swap dup
		buf swap 0. 2swap >number 2drop drop
		swap rot
	else swap drop
	then ;

: read3lines ( -- num1 num2 num3 offset-fwd buf-flag)
	readnum 2drop
	readnum drop
	readnum  swap 2swap -rot + 2 + rot ;

: back2lines ( offset-fwd -- )
	-1 M* fd-in file-position drop d+ fd-in reposition-file drop ;

: part2 ( -- n)
-1 0
begin
	read3lines
while
	back2lines
	+ + dup
	rot > negate rot + swap
repeat 2drop drop ;

( MAIN )
." Part 1: " part1 . cr
0. fd-in reposition-file
." Part 2: " part2 . cr