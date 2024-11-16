%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
int yylex(void);
%}

%token NUMBER
%left '+' '-'   /* Left associativity, same precedence */
%left '*' '/'   /* Left associativity, higher precedence */

%%

program:
    program expr '\n'    { printf("Result: %d\n", $2); }
    | /* empty */
    ;

expr:
    NUMBER              { $$ = $1; }
    | expr '+' expr     { $$ = $1 + $3; }
    | expr '-' expr     { $$ = $1 - $3; }
    | expr '*' expr     { $$ = $1 * $3; }
    | expr '/' expr     { 
                         if($3 == 0) {
                             yyerror("Division by zero!");
                             exit(1);
                         }
                         $$ = $1 / $3; 
                       }
    | '(' expr ')'      { $$ = $2; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("Enter arithmetic expressions (press Ctrl+D to exit):\n");
    yyparse();
    return 0;
}