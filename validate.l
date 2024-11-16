%{
#include "y.tab.h"
void yyerror(char *);
%}

%%
[aA]    { return A; }
[bB]    { return B; }
[cC]    { return C; }
[dD]    { return D; }
\n      { return NL; }
[ \t]   ; /* Skip whitespace */
.       { yyerror("Invalid character"); }
%%

int yywrap(void) {
    return 1;
}