// ANKIT KUMAR
// 2020UCS0118
// YACC PROGRAM

%{

// header file

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

// aray storing bounded variables and total variables
char bound_var[100];
char totalvar[100];

// storing the number of bounded variables
int aa=0;
int bb=0;

// these are yacc functions 
void yyerror(char*);// return error
int yywrap();
int yylex();// return tokens

void Lambda_To_C(); // Program to print C program from Lambda calculas
%}

%start List

%union { int a; char b;}


%token <b> LAMBDA PERIOD LEFTPAREN RIGHTPAREN
%token <a> VARIABLE

%left '|'

%%                   
/* beginning of rules section */
List : |
        List E '\n' {
            Lambda_To_C();
        }
        |
        List error '\n' {
          yyerrok;
        };
E :     |
        VARIABLE E{
        totalvar[aa++] = $1 + 'a';
        }
        |
        LAMBDA VARIABLE PERIOD E  {
        bound_var[bb++] = $2+ 'a';
        } 
        |
        LEFTPAREN E RIGHTPAREN
        ;

%%



int main(){
 return (yyparse());
}
void Lambda_To_C(){
    // HEADER files
    printf("#include<stdio.h>\n");
    printf("#include<string.h>\n");
    printf("#include<stdlib.h>\n");

    int cc=0;
    int free_var[100];
    for(int i=0;i<aa;i++){
        int F=1;
        for(int j=0;j<bb;j++){
            if(totalvar[i]==bound_var[j] ){  
                 F=0;
                 break;
            }
        }
        if(F==1){
            free_var[cc++]=totalvar[i];
        }
    }

    // global variable
    for(int j=0;j<cc;j++){
        printf("char %c[10];\n",free_var[j]);

  }

    printf("char* func_to_Lambda_cal(");
    for(int i=0;i<bb;i++){
        printf("char* %c",bound_var[i]);
        if(i!=bb-1){
        printf(",");
        }
    }
    printf("){\n");
    printf("\tstrcat(%c,\"\");\n",totalvar[0]);
    for(int i=1;i<aa;i++){
        printf("\tstrcat(%c,%c);\n",totalvar[0],totalvar[i]);
    }
    printf("\treturn strcat(%c,\"\");\n",totalvar[0]);
    printf("}\n");
    printf("\n");
    printf("\n");
    printf("\n");
    printf("int main() {\n");
    for(int i=0;i<bb;i++){
        printf("\n\tchar %c[10];",bound_var[i]);
        printf("\n\tprintf(\"The entered the value of %c :\");",bound_var[i]);
        printf("\n\tgets(%c);",bound_var[i]);

    }
    printf("\n\tprintf(func_to_Lambda_cal(");
    for(int i=0;i<bb;i++){
        printf("%c",bound_var[i]);
        if(i!=bb-1){
        printf(", ");
        }
    }
    printf("));\n");
    printf("\treturn 0;\n");
    printf("}\n");

}


void yyerror(char* s){
  fprintf(stderr, "%s\n",s);
}

int yywrap(){
  return(1);
}
