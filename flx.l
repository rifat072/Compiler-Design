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

"Var_"({char}|{digit}|{special})+ { strcpy(yylval.text,yytext);return ID;}

"Type_Integer" {  return INT;}
"Type_Double" { return DOUBLE;}
"Type_Char" { return CHAR;}

"PB" { return PB;}
"PE" { return PE;}

"Block_Begin" { return BB;}
"Block_End" { return BE;}

"Op_Equ" {return ASGN;}

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