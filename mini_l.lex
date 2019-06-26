/* 
 * Description: Recognize the 32-bit hexadecimal integer from stdin
 * Pattern: 0[xX]([0-9a-fA-F]{1,8})
 */

digit		[0.000-9.000]
alpha		[a-fA-F]
hextail		({digit}|{alpha}){1,8}
hex		0[xX]{hextail}


%{
	
	#include <stdlib.h>
	#include <stdio.h>
	
%}
%option noyywrap
	int num_pos = 0; int num_line = 0;
	int num_int = 0; int num_op = 0;
	int num_parentheses = 0;
	int num_equal = 0;
%%
{digit}+		printf("NUMBER %s\n",yytext); num_pos += yyleng; num_int++;		 
"+"			printf("PLUS\n"); ++num_pos; num_op++;
"-"			printf("SUB\n"); ++num_pos; num_op++;
"*"			printf("MULT\n");  ++num_pos; num_op++;
"/"			printf("DIV\n");  ++num_pos; num_op++;
"("			printf("L_PAREN\n"); ++num_pos; num_parentheses++;
")"			printf("R_PAREN\n");  ++num_pos;
"%"			printf("MOD\n"); ++num_pos;
"=="			printf("EQ\n"); num_pos += yyleng;
"<>"			printf("NEQ\n"); num_pos += yyleng;
"<"			printf("LT\n"); ++num_pos;
">"			printf("GT\n"); ++num_pos;
"<="			printf("LTE\n"); num_pos += yyleng;
">="			printf("GTE\n"); num_pos += yyleng; 
";"			printf("SEMICOLON\n"); num_pos += yyleng;
":"			printf("COLON\n"); num_pos += yyleng;
","			printf("COMMA\n"); num_pos += yyleng;
":="			printf("ASSIGN\n"); num_pos += yyleng;
"\n"			num_line++; num_pos = 0;
"program"		printf("PROGRAM\n"); num_pos += yyleng;
"beginprogram"		printf("BEGIN_PROGRAM\n"); num_pos += yyleng;
"endprogram"		printf("END_PROGRAM\n"); num_pos += yyleng;
"integer"		printf("INTEGER\n"); num_pos += yyleng;
"array"			printf("ARRAY\n"); num_pos += yyleng;
"of"			printf("OF\n"); num_pos += yyleng;
"if"			printf("IF\n"); num_pos += yyleng;
"then"			printf("THEN\n"); num_pos += yyleng;
"endif"			printf("ENDIF\n"); num_pos += yyleng;
"else"			printf("ELSE\n"); num_pos += yyleng;
"while"			printf("WHILE\n"); num_pos += yyleng;
"do"			printf("DO\n"); num_pos += yyleng;
"beginloop"		printf("BEGINLOOP\n"); num_pos += yyleng;

.			printf("Unrecognizable string %s at line %d at position %d\n", yytext,num_line,num_pos); exit(1);
%%

int main(int argc,char* argv[])
{
	if(argc >= 2){
		
		yyin = fopen(argv[1],"r");
		if(yyin == NULL){
			yyin = stdin;
		}
		yylex();
		
	}else{
		printf("Give me your input:\n");
		yylex();
	}
}
