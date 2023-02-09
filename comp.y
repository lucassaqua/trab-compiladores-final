%{
 #include <stdio.h>
 #include <stdlib.h> 
 #include <string.h>
 int yylex(void);
 void yyerror(char *);
 int sym[26]; 
 int x=1;
%}

%token  NEXT_LINE
%token  ATRIBUICAO 
%token  VAR
%token  INTEGER 
%token  SEMICOLON 
%token  IF 
%token  ELSE 
%token  END_EXPRESSION
%token  SUM 
%token  SUB 
%token  DIV 
%token  MULT 
%token  EQ 
%token  DIF 
%token  LESS 
%token  GREATER 
%token  LESS_EQ 
%token  GREATER_EQ 
%token  WHILE 
%token  POT
%token  FOR
%token  PRINT 

%start program



%left EQ
%left MULT
%left SUM
%left SUB
%left DIV
%left IF
%right PRINT

%%

program:
    program expr 
    | expr
    | condicional
    | program condicional
    | loop
    | program loop
    | program NEXT_LINE
    | NEXT_LINE
    ;


expr:
    variable
    | arithmetic
    | logical
    | PRINT expr SEMICOLON              {if (x){printf("%d\n", $2);x=0;}else{x = 1;}} 
    | loop
    ;

variable:
    INTEGER                             { $$ = $1; }
    | VAR                               { $$ = sym[$1];}

logical:
    expr EQ     expr                    {$$=x=$1==$3;}
    | expr GREATER  expr                {$$=x=$1>$3;}
    | expr     LESS       expr          {$$=x=$1<$3;}
    | expr   GREATER_EQ      expr       {$$=x=$1>=$3;}
    | expr   LESS_EQ      expr          {$$=x=$1<=$3;}
    | expr   DIF     expr               {$$=x=$1!=$3;}

arithmetic:
    VAR ATRIBUICAO expr  SEMICOLON    { sym[$1] = $3; }
    | VAR ATRIBUICAO SUM expr  SEMICOLON    { sym[$1] = sym[$1] + $4 ;}
    | VAR ATRIBUICAO SUB expr  SEMICOLON    { sym[$1] = sym[$1] - $4; }
    | VAR ATRIBUICAO MULT expr  SEMICOLON    { sym[$1] = sym[$1] * $4; }
    | VAR ATRIBUICAO DIV expr  SEMICOLON    { sym[$1] = sym[$1] / $4; }
    | expr SUM expr                     {$$ = $1 + $3; } 
    | expr SUB expr                     {$$ = $1 - $3; } 
    | expr MULT expr                    {$$ =  $1 * $3; } 
    | expr DIV expr                     { $$ = $1 / $3; } 
    | expr POT      expr           { for(int i=1;i<$3;i++){$$=$$*$1;}}

condicional:
    IF  expr END_EXPRESSION program SEMICOLON  {x=0; if(x == 1 && $2){$4;}x=1; }
  | IF expr END_EXPRESSION program ELSE  END_EXPRESSION program SEMICOLON  {x=0; if(x == 1 && $2){$4;x=0;}else{$7;}x=1;}
;

loop:  WHILE  expr END_EXPRESSION program SEMICOLON  {x=0;while(x == 1 && $2){$4;}}
    |   FOR variable LESS_EQ variable END_EXPRESSION program SEMICOLON {for(int i =$2; $2<=$4; i++){$6;}}
    ;


%%

void yyerror(char *s) {
 fprintf(stderr, "%s\n", s);
 
}

int main(void) {
 yyparse();
 return 0;
}