%{
#include <stdio.h>
int yylex();
%}

%token OP_ADD OP_SUB OP_MULT OP_DIV TK_LEFT_PAR TK_RIGHT_PAR
%token TK_NUMBER
%token TK_EOL
%token TK_EOF

%%

expr: expr OP_ADD term
    | expr OP_SUB term
    | term
;

term: term OP_MULT factor
    | term OP_DIV factor
    | factor
;

factor: TK_NUMBER
    | TK_LEFT_PAR expr TK_RIGHT_PAR
;