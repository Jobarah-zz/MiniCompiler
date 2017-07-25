%{
#include <stdio.h>
int yylex();
void yyerror(const char *msg);

void yyerror(const char *msg) {
    printf("%s\n", msg);
}

#define YYERROR_VERBOSE 1
%}

%token OP_ADD OP_SUB OP_MULT OP_DIV TK_LEFT_PAR TK_RIGHT_PAR
%token TK_NUMBER
%token TK_EOF
%token TK_EOL
%token TK_ERROR

%%

exprs: expr
    | expr TK_EOL exprs
    |

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