%{
#include <stdio.h>
#include "y.tab.h"    /* This line is crucial - includes token definitions */
%}

%%
[aA]    { return A; }
[bB]    { return B; }
[ \t]   ;           /* skip whitespace */
\n      { return 0; }
.       { return yytext[0]; }
%%

int yywrap(void) {
    return 1;
}