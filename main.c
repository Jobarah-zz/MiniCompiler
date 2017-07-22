#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"

int expr();
int yylex();
extern int token;
extern char *yytext;

int main(){
    
    token = yylex();

    int r = expr();

    printf("Result = %d\n", r);

    while(1) {
        if(token == TK_EOL) {
            token = yylex();

            if(token == TK_LEFT_PAR || token == TK_NUMBER) {
                r = expr();
                printf("Result = %d\n", r);
            } else {
                break;
            }
        }
    }
}