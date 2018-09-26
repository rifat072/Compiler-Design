char [a-zA-Z]
digit [0-9]
special [$_@]
space " "
newline "\n"
Datatype "Type_Integer"|"Type_Double"|"Type_Char"|"Type_Void"
Operator "Op_Equ"|"Op_Plus"|"Op_Minus"|"Op_Divide"|"Op_Multiply"|"Op_And"|"Op_Or"|"Op_Mod"
Relational_Operator "Ro_GT"|"Ro_LT"|"Ro_GE"|"Ro_LE"|"Ro_And"|"Ro_Or"|"Ro_Equ"|"Ro_Equ"|"Ro_NEqu"

%{
	int k = 0;
	int i = 0;
	int s = 0;
	int c = 0;
%}

%%
{space}|{newline} {}

"#".*"#" {printf("This is Comment\n");}
{Operator} {printf("This is Operator\n");k++;}
{Datatype} {printf("This is Datatype\n");k++;}
{Relational_Operator} {printf("This is Relational_Operator\n");k++;}
"Var_"({char}|{digit}|{special})+ {printf("This is Variable\n");i++;}
"Func_"({char}|{digit}|{special})+ {printf("This is Function\n");i++;}
"!Header" {printf("Header\n");k++;}
"!Define" {printf("Define\n");k++;}
"Block_Begin" {printf("Block Begins Here\n");k++;}
"Block_End" {printf("Block End Here\n");k++;}
"PE" {printf("Parameter Bracket End\n");k++;}
"PB" {printf("Parameter Bracket Start\n");k++;}
"If" {printf("If Detected\n");k++;}
"Else" {printf("Else Detected\n");k++;}
"Else If" {printf("Else if Detected\n");k++;}
"For" {printf("For Detected\n");k++;}
"Return" {printf("Function Return\n");k++;}
"AddressOf" {printf("AddressOf Operator found\n");k++;}
\".*\" {printf("String\n");s++;}
";" {printf("Semicolon\n");}
{digit}* {printf("Integer Constant\n");c++;}
{digit}*"."{digit}+ {printf("Double Constant\n");c++;}
\'{char}\' {printf("Character Constant\n");c++;}
. {}
%%

int yywrap(){
	return 1;
}

int main(){
	freopen("test.HQ9","r",stdin);
	freopen("output.txt","w",stdout);
	yylex();
	printf("\n\n\n KeyWord found = %d\n Identifier Found = %d\nString Found = %d\nConstant Found = %d\n",k,i,s,c);
}