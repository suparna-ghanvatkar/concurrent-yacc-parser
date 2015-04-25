%{
#include <stdio.h>
#include <omp.h>
#include <string.h>
FILE *yyin;
#define YYSTYPE int
typedef void* yyscan_t;
extern int yylex();
extern int yylex_init(void *);
extern int yyset_in(FILE*,yyscan_t);
extern int yylex_destroy(void *);
%}
%pure-parser
%token digit NUMBER
%lex-param {void* yyscan_t}
%parse-param {void* yyscan_t}
%start list
%left '+' '-' '*' '/' 
%union {int i;}
%%

list:   |
	list stat '\n'
        ;

stat:   expr { printf("Thread = %ld ... Ans = %d\n",omp_get_thread_num(),$1);}
        ;

expr: 
        expr '*' expr { $$ = $1 * $3; }
        |
        expr '/' expr { $$ = $1 / $3; }
        |
        expr '+' expr { $$ = $1 + $3; }
        |
        expr '-' expr { $$ = $1 - $3; }
        |
	    NUMBER
        ;
        
%%
int yyerror()
{
    return 1;
}
int main(int argc, char *argv[])
{
  int num,i=0;
  printf("How many threads you want to create??\n");
  scanf("%d", &num);
   #pragma omp parallel for
	for(i=0;i<num;i++)
	{
		yyscan_t s;
		  FILE *file_pointer;
		  file_pointer = fopen("test.txt", "r");
		  yylex_init(&s);
		  yyset_in((FILE *)file_pointer,s);
		  yyparse(s);
		  yylex_destroy(s);
		  fclose(file_pointer);
		sleep(1);
	}
	return 0;
}

