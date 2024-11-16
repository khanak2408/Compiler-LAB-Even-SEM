%{
#include <stdlib.h>
#include "y.tab.h"
void yyerror(char *);
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[-+*/()]    { return *yytext; }
[ \t]       ;  
\n          { return '\n'; }
.           { yyerror("Invalid character"); }
%%

int yywrap(void) {
    return 1;
}