/* 
 * Description: Recognize the 32-bit hexadecimal integer from stdin
 * Pattern: 0[xX]([0-9a-fA-F]{1,8})
 */

digit		[0-9]
alpha		[a-fA-F]
hextail		({digit}|{alpha}){1,8}
hex		0[xX]{hextail}


%{
	#include <stdlib.h>
	#include <stdio.h>
%}
%option noyywrap
	int num_pos = 0; int num_line = 0;
%%
{digit}+		printf("NUMBER %s\n",yytext); num_pos += yyleng; 		 
"+"			printf("PLUS\n"); ++num_pos;
"-"			printf("MINUS\n"); ++num_pos;
"*"			printf("MULT\n");  ++num_pos; 
"/"			printf("DIV\n");  ++num_pos; 
"("			printf("L_PAREN\n"); ++num_pos; 
")"			printf("R_PAREN\n");  ++num_pos;
"="			printf("EQUAL\n"); exit(1);
"\n"			num_line++; num_pos = 0;
.			printf("Unrecognizable string %s at line %d at position %d\n", yytext,num_line,num_pos); exit(1);
%%

int main(int argc,char* argv[])
{
	if(argc >= 2){

	}else{
		printf("Give me your input:\n");
		yylex();
	}
}
