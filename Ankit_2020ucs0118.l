/* ANKIT KUMAR */
/* 2020UCS0118 */
/* LEX PROGRAM */

%{

#include "y.tab.h"
#include <stdio.h>
#include <string.h>
int i;
char c;

%}


%%

" "       ;
[a-z]     {
            i = yytext[0];
            yylval.a = i - 'a';
            return(VARIABLE);
          }
[L]       {
            c = yytext[0];
            yylval.b = c;
            return(LAMBDA);
          }
[.]       {
            c = yytext[0];
            yylval.b = c;
            return(PERIOD);
          }
[(]       {
            c = yytext[0];
            yylval.b = c;
            return(LEFTPAREN);
          }
[)]       {
            c = yytext[0];
            yylval.b = c;
            return(RIGHTPAREN);
          }
[^a-zL.()\b]  {
                i = yytext[0];
                return(i);
              }
%%