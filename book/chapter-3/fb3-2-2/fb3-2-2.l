
%option noyywrap nodefault yylineno

%{
    #include "fb3-2-2.h"
    #include "fb3-2-2.yy.hpp"
%}

EXP         ([eE][+-]?[0-9]+)

%%

"+" |
"-" |
"*" |
"/" |
"=" |
"|" |
"," |
";" |
"{" |
"}" |
"(" |
")" {  return yytext[0]; }

">"         { yylval.fn = 1; return CMP; }
"<"         { yylval.fn = 2; return CMP; }
"<>" | "!=" { yylval.fn = 3; return CMP; }
"=="        { yylval.fn = 4; return CMP; }
">="        { yylval.fn = 5; return CMP; }
"<="        { yylval.fn = 6; return CMP; }

"if"        { return IF; }
"then"      { return THEN; }
"else"      { return ELSE; }
"while"     { return WHILE; }
"do"        { return DO; }
"let"       { return LET; }


"sqrt"      { yylval.fn = B_sqrt;  return FUNC; }
"exp"       { yylval.fn = B_exp;   return FUNC; }
"log"       { yylval.fn = B_log;   return FUNC; }
"echo"      { yylval.fn = B_print; return FUNC; }

[a-zA-Z][a-zA-Z0-9_]*     { yylval.s = lookup(yytext); return NAME; }

[0-9]+{EXP}? |
[0-9]+"."[0-9]*{EXP}? |
"."[0-9]*{EXP}? { yylval.d = atof(yytext); return NUMBER;}

"//".* ;

\\\n    ;
\n      { return EOL; }

<<EOF>>  return EOFILE;

[ \t]   ;
.       { yyerror("unknown character %s", yytext); }

%%