#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"

int exprs();
int yylex();
extern int token;
extern char *yytext;

int main(){
    
    exprs();
}