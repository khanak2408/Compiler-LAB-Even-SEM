%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
int yylex(void);
%}

%token A B

%%
S : T              { printf("Valid string\n"); }
  ;

T : A T B          
  | A              
  | A A            
  | A A A          
  | A B B B        
  | A A A B        
  ;
%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("Enter a string: ");
    yyparse();
    return 0;
}