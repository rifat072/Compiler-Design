char [a-zA-Z]
digit [0-9]
special [$_@]
space " "
newline "\n"
Datatype "Type_Integer"|"Type_Double"|"Type_Char"|"Type_Void"
Operator "Op_Equ"|"Op_Plus"|"Op_Minus"|"Op_Divide"|"Op_Multiply"|"Op_And"|"Op_Or"|"Op_Mod"
Relational_Operator "Ro_GT"|"Ro_LT"|"Ro_GE"|"Ro_LE"|"Ro_And"|"Ro_Or"|"Ro_Equ"|"Ro_Equ"|"Ro_NEqu"

%{
	#include "bison.tab.h"
	#include <string.h>
	int yyparse();
	int yylex();
	int yyerror();
%}



%%
{space}|{newline} {}
"#".*"#" {/*This is comment*/}
";" {return SM;}
"," {return CM;}
{digit}+ 	{
				yylval.val = atoi(yytext);
				return NUM;
			}

"Func_Main" { return MAIN;}
"Func_PrintVariable" { return PRINTVAR;}
"Func_PrintString" {return PRINTSTR;}
"Func_PrintNewLine" {return PRINTLN;}

"Func_"({char}|{digit}|{special})+ {return FUNCTION;}

"Var_"({char}|{digit}|{special})+ { strcpy(yylval.text,yytext);return ID;}

"Type_Integer" {  return INT;}
"Type_Double" { return DOUBLE;}
"Type_Char" { return CHAR;}

"PB" { return PB;}
"PE" { return PE;}

"Block_Begin" { return BB;}
"Block_End" { return BE;}

"Op_Equ" {return ASGN;}
"Op_Plus" {return PLUS;}
"Op_Minus" {return MINUS;}
"Op_Multiply" {return MULT;}
"Op_Divide" {return DIV;}
"Ro_LT" {return LT;}
"Ro_GT" {return GT;}
"Ro_LE" {return LE;}
"Ro_GE" {return GE;}
"Ro_Equ" {return EQU;}
"Ro_NEqu" {return NEQU;}

"ElseIf" {return ELSEIF;}
"If" { return IF;}
"Else" {return ELSE;}

"For" {return FOR;}
"IncrementBy" {return INC;}
"To" {return TO;}

"Switch" {return SWITCH;}
"*" {return DEFAULT;}
":" {return COL;}
. {}


"\""(.)*"\"" {strcpy(yylval.text,yytext);return STR;}




%%


int yywrap()
{
	return 1;
}


int main(){
	yyin = freopen("sample.txt","r",stdin);
	//freopen("output.txt","w",stdout);
	yyparse();
}