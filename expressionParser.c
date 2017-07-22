#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"

int token;
int expr();
int term();
int factor();
int yylex();
extern char *yytext;

int expr() {
    int result = term();

    switch(token) {

        case OP_SUB:
        case OP_ADD: {

            while(token == OP_ADD || token == OP_SUB) {
                int op = token;
                token = yylex();

                if(op == OP_ADD)
                    result += term();
                else
                    result -= term();
            }

            break;
        }
        default: 
            break;
    }

    return result;
}

int term() {
    int result = factor();

    switch(token) {
        case OP_DIV:
        case OP_MULT: {

            while(token == OP_MULT || token == OP_DIV) {
                int op = token;
                token = yylex();

                if(op == OP_MULT)
                    result *= factor();
                else
                    result /= factor();
            }
            break;
        }
        default: 
            break;
    }

    return result;
}

int factor() {

    switch(token) {

        case TK_NUMBER: {

            int r = atoi(yytext);
            token = yylex();
            return r;
        }
        case TK_LEFT_PAR: {

            token = yylex();
            int result = expr();

            if (token == TK_RIGHT_PAR) {

                token = yylex();
            } else {

                printf("ERROR expected ')' \n");
            }
            return result;
        }
        default:
            printf("ERROR: expected '(' or a number \n");
        return -1;
    }
}