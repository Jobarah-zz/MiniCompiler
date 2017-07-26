%{
#include <stdio.h>

int arr[8];

int yylex();
void yyerror(const char *msg);
extern int yylineno;
void yyerror(const char *msg) {
    printf("Line %d %s\n", yylineno, msg);
}

#define YYERROR_VERBOSE 1
%}

%token OP_ADD OP_SUB OP_MULT OP_DIV TK_LEFT_PAR TK_RIGHT_PAR
%token TK_NUMBER
%token TK_EOF
%token TK_EOL
%token TK_ERROR
%token TK_PRINT
%token TK_ASSIGN
%token TK_ID
%%

input: stmnt_list opt_eols
;

stmnt_list: stmnt_list eols statement
    | statement
;

eols: eols TK_EOL
    | TK_EOL
;

opt_eols: eols
    |
;

assign_statement: TK_ID TK_ASSIGN expr { arr[$1] = $3; }
;

statement: print
    | assign_statement
;

expr: expr OP_ADD term { $$ = $1 + $3; }
    | expr OP_SUB term { $$ = $1 - $3; }
    | term { $$ = $1; }
;

term: term OP_MULT factor { $$ = $1 * $3; }
    | term OP_DIV factor { $$ = $1 / $3; }
    | factor { $$ = $1; }
;

factor: TK_NUMBER { $$ = $1; }
    | TK_LEFT_PAR expr TK_RIGHT_PAR { $$ = $2; }
;

print: TK_PRINT TK_LEFT_PAR expr TK_RIGHT_PAR { printf("%d\n", $3); }
    | TK_PRINT TK_ID { printf("%d\n", arr[$2]); }
;