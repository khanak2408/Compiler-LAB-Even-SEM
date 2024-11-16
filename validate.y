%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
int yylex(void);
int countA = 0;  /* Count of 'a's */
int countB = 0;  /* Count of 'b's */
int countC = 0;  /* Count of 'c's */
int countD = 0;  /* Count of 'd's */
%}

%token A B C D NL

%%

start: 
    | start line
    ;

line: expr NL    {
    if(countA > 0 && countA == countB && countC > 0 && countC == countD) {
        printf("Valid string! n=%d, m=%d\n", countA, countC);
    } else {
        printf("Invalid string! a=%d, b=%d, c=%d, d=%d\n", 
               countA, countB, countC, countD);
    }
    /* Reset counters for next input */
    countA = countB = countC = countD = 0;
}
;

expr: a_section b_section c_section d_section
    ;

a_section: A           { countA++; }
    | a_section A      { countA++; }
    ;

b_section: B           { countB++; }
    | b_section B      { countB++; }
    ;

c_section: C           { countC++; }
    | c_section C      { countC++; }
    ;

d_section: D           { countD++; }
    | d_section D      { countD++; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("Enter strings (format: a^n b^n c^m d^m, where n,m > 0)\n");
    printf("Examples: abcd, aabbccdd\n");
    printf("Press Ctrl+D to exit\n");
    yyparse();
    return 0;
}