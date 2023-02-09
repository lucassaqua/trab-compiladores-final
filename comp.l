%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
%}



CHAR            [a-zA-Z]    
STRING          {CHAR}{CHAR}+
ALFANUMERIC     {STRING}({STRING}|{INTEIRO})

%%

[0-9]+              {yylval = atoi(yytext);
                            return INTEGER;}
                            
{CHAR}                  {yylval= *yytext - 'a';
                        return VAR;}

"<-"                    {return ATRIBUICAO;}

"+"                      {return SUM;}
"-"                      {return SUB;}
"*"                      {return MULT;}
"/"                      {return DIV;}
"^"                      {return POT;}

"="                      {return EQ;}                   
"<>"                     {return DIF;}                   
"<"                      {return LESS;}                   
">"                      {return GREATER;}                   
"<="                     {return LESS_EQ;}                   
">="                     {return GREATER_EQ;}          

"if"                     {return IF;}
"else"                   {return ELSE;}

"while"                  {return WHILE;}
"for"                    {return FOR;}

\n                       {return NEXT_LINE;}

"print"                  {return PRINT;}

":"                      {return END_EXPRESSION;}

";"                      {return SEMICOLON;}

[ \t]                   ; /* skip whitespace */


%%

int yywrap(void) {
 return 1;
}