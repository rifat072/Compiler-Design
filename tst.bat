bison -d bison.y
flex flx.l
gcc lex.yy.c bison.tab.c -o test
test