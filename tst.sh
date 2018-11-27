bison -d bison.y
flex flx.l
gcc bison.tab.c lex.yy.c -o test
./test
