%option noyywrap
%option yylineno

%{
#include <stdio.h>
#include "tokens.h"
%}

%%
[ \t]   { /* ignore spaces */ }
"="     { return TK_ASSIGN; }
"+"     { return OP_ADD; }
"-"     { return OP_SUB; }
"*"     { return OP_MULT; }
"/"     { return OP_DIV; }
"("     { return TK_LEFT_PAR; }
")"     { return TK_RIGHT_PAR; }
[0-9]+  { yylval = atoi(yytext); return TK_NUMBER; }
"$"[0-7]    { yylval = yytext[1] - '0';  return TK_ID; }
"print" { return TK_PRINT; }
"\n"    { return TK_EOL; }
.       { return TK_ERROR; }
%%