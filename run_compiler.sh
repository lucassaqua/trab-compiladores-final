lex comp.l &&
yacc -d comp.y &&
gcc -o comp.out lex.yy.c y.tab.c &&
./comp.out < teste.txt &&
rm y.tab.h y.tab.c lex.yy.c