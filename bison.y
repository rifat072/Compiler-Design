/* C Declarations */

%{
	#include<stdio.h>
	#include<stdlib.h>
	#include <string.h>

    int ptr = 0;
    int value[1000];
    char varlist[1000][1000];

    ///if already declared  return 1 else return 0
    int isdeclared(char str[]){
        int i;
        for(i = 0; i < ptr; i++){
            if(strcmp(varlist[i],str) == 0) return 1;
        }
        return 0;
    }
    /// if already declared return 0 or add new value and return 1;
    int addnewval(char str[],int val){
        if(isdeclared(str) == 1) return 0;
        strcpy(varlist[ptr],str);
        value[ptr] = val;
        ptr++;
        return 1;
    }

    ///get the value of corresponding string
    int getval(char str[]){
        int indx = -1;
        int i;
        for(i = 0; i < ptr; i++){
            if(strcmp(varlist[i],str) == 0) {
                indx = i;
                break;
            }
        }
        return value[indx];
    }


%}

%union {
  char text[1000];
  int val;
}


%token <text>  ID
%token <val>  NUM
%token <text> STR

%type <val> expression

%left LT GT LE GE
%left PLUS MINUS
%left MULT DIV



%token INT DOUBLE CHAR MAIN PB PE BB BE SM CM ASGN PRINTVAR PRINTSTR PRINTLN PLUS MINUS MULT DIV LT GT LE GE
%nonassoc IFX
%nonassoc ELSE



%%

program		: INT MAIN PB PE BB statement BE { printf("\nCompilation Successful\n"); }
			;
statement	: /* empty */
			| statement declaration
			| statement print
			| statement expression {printf("Value of the expression: %d\n",$2);}
			;




/*--------declaration begin--------*/


declaration : type variables SM {}
			;
type		: INT | DOUBLE | CHAR {}
			;
variables	: variable CM variables {}
			| variable {}
			;
variable   	: ID 	{
						//printf("%s\n",$1);
						int x = addnewval($1,0);
						if(!x) {
							printf("Compilation Error:Variable %s is already declared\n",$1);
							exit(-1);
						}

					}
			| ID ASGN expression 	{
										//printf("%s %d\n",$1,$3);
										int x = addnewval($1,$3);
										if(!x) {
											printf("Compilation Error: Variable %s is already declared\n",$1);
											exit(-1);
											}
									}

			;

/*-------declaration end----------*/


/*--------printing begin----------*/

print		: PRINTVAR PB ID PE SM 	{
										if(!isdeclared($3)){
											printf("Compilation Error: Variable %s is not declared\n",$3);
											exit(-1);
										}
										else{
											int v = getval($3);
											printf("%d",v);
										}
									}
			| PRINTSTR PB STR PE SM {
										int l = strlen($3);
										int i;
										for(i = 1;  i < l-1; i++) printf("%c",$3[i]);
									}
			| PRINTLN PB PE	SM 	{
									printf("\n");
								}
			;



/*--------printing end------------*/

/*--------expression Begin--------*/

expression : NUM {$$ = $1;}
			| ID 	{
						if(!isdeclared($1)) {
							printf("Compilation Error: Variable %s is not declared\n",$1);
							exit(-1);
						}
						else{
							$$ = getval($1);
						}
				 	}
			| expression PLUS expression {$$ = $1 + $3;}
			| expression MINUS expression {$$ = $1 - $3;}
			| expression MULT expression {$$ = $1 * $3;}
			| expression DIV expression {
											if($3) {
				     							$$ = $1 / $3;
				  							}
									  		else {
												$$ = 0;
												printf("\nRuntime Error: division by zero\t");
												exit(-1);
									  		} 
										}
			| expression LT expression	{ $$ = $1 < $3; }
			| expression GT expression	{ $$ = $1 > $3; }
			| expression LE expression	{ $$ = $1 <= $3; }
			| expression GE expression	{ $$ = $1 >= $3; }
			| PB expression PE		{$$ = $2;}
			;


/*--------expression Begin--------*/

%%


int yyerror(char *s){
	printf( "%s\n", s);
}
