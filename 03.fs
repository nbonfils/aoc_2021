13 constant bufsize
bufsize 1- constant len
create buf bufsize 2 + allot

s" 03.txt" r/o open-file throw value fd-in

( PART 1 )
variable counts len 1- cells allot
2 len ** 1- constant bitmask

: invert-value ( n -- n )
	invert bitmask and ;

: reset-count ( -- )
	counts len cells 0 fill ;

: count ( pos -- addr )
	cells counts + ;

: update-count ( c-pos str* -- )
	over + c@ [char] 1 = if 1 swap count +! else -1 swap count +! then ;

: >count ( -- )
	begin
		buf bufsize fd-in read-line throw
	while
		0 do
			i buf update-count
		loop
	repeat drop ;

: count> ( -- count-value )
	0
	len 0 do
		i count @ 0>= if 1+ then 2*
	loop 2/ ;

: gamma count> ;
: epsilon count> invert-value ;

: part1
	reset-count
	>count
	gamma epsilon * ;

cr ." Part 1: " part1 .

( PART 2 )
: str-list ( str* str-len -- list* )   create here -rot here -rot dup , dup >r here swap cmove r> allot dup , , ;
: s@ ( list* -- str* str-len )   dup cell+ swap @ ;
: next ( list* -- next* )   dup @ + cell+ @ ;
: prev ( list* -- prev* )   dup @ + 2 cells + @ ;
: add ( list* str* str-len -- )
	here -rot dup ,
	dup >r here swap cmove r> allot
	swap dup ,
	dup prev ,
	2dup prev dup @ + cell+ !
	dup @ + 2 cells + ! ;
: rm ( node* -- )
	dup next swap prev 2dup
	dup @ + cell+ !
	swap dup @ + 2 cells + ! ;
: dump-list ( list* -- )
	dup
	begin
		cr dup s@ type
		next
		2dup =
	until 2drop ;

: str-list<file
	buf bufsize fd-in read-line throw drop buf swap str-list
	begin
		buf bufsize fd-in read-line throw
	while
		over buf rot add
	repeat 2drop ;

0 fd-in reposition-file
str-list<file o2
0 fd-in reposition-file
str-list<file co2

: o2-crit<list ( list* c-pos -- list* c-pos crit )
	over
	begin
		2dup s@ drop update-count
		next
		dup next 2over drop =
	until
	2dup s@ drop update-count drop
	dup count @ 0>= negate ;

: co2-crit<list ( list* c-pos -- list* c-pos crit )
	over
	begin
		2dup s@ drop update-count
		next
		dup next 2over drop =
	until
	2dup s@ drop update-count drop
	dup count @ 0< negate ;

: satisfy-crit ( list* c-pos crit -- flag )
	[char] 0 + -rot
	swap s@ drop + c@ = ;

: filter-list ( list* c-pos crit -- filtered-list* )
	2over swap drop
	begin
		2over drop swap dup next rot <>
	while
		dup 2over satisfy-crit invert if				( if current entry doesn't satisfy criterion )
			2over drop over = if					( if current entry is head of list )
				next 2swap swap >r rot r> then	( replace list head with next )
			dup rm then
		next
	repeat
	dup 2over satisfy-crit invert if
		2over drop over = if
			next 2swap swap >r rot r> then
		dup rm then
	2drop drop ;

: o2-rate ( -- )
	0. o2
	len 0 do
		reset-count
		i o2-crit<list filter-list
		dup dup next = if leave then
	loop
	2 base !
	s@ >number 2drop drop
	decimal ;

: co2-rate ( -- )
	0. co2
	len 0 do
		reset-count
		i co2-crit<list filter-list
		dup dup next = if leave then
	loop
	2 base !
	s@ >number 2drop drop
	decimal ;

: part2 o2-rate co2-rate * ;

cr ." Part 2: " part2 .


