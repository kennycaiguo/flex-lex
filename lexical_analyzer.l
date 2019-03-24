/***
  Definitions Section
***/

%{
  #define TOKEN_COUNT 0
  #define LEXEME_COUNT 1

  int literals[2] = {0, 0};
  int identifiers[2] = {0, 0};
  int keywords[2] = {0, 0};
  int integers[2] = {0, 0};
  int floats[2] = {0, 0};
  int punctuation[2] = {0, 0};
  int operators[2] = {0,0};
%}

QUOTED_STRING \".*\"
KEYWORDS (auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while)
UNARY_OPERATORS (\+|-|\*|\/|\+\+|--)
ASSIGNMENTS (\+=|-=|\*=|\/=|=)
LOGICAL_OPERATORS (\|\||&&|>|<|>=|<=|==|!=)
BITWISE_OPERATORS (\^)
LEFT_PAREN \(
RIGHT_PAREN \)
SEPARATOR ,
TERMINATOR ;
LEFT_CURLY_BRACKET \{
RIGHT_CURLY_BRACKET \}
LEFT_BRACKET \[
RIGHT_BRACKET \]
COMMENT [\/\*.*\*\/|\/\/.*\n]
QUESTION_MARK \?
COLON :

%%
{QUOTED_STRING}  {
  printf("string literal: %s\n", yytext);
  literals[TOKEN_COUNT] = 1;
  literals[LEXEME_COUNT] += 1;
}

{KEYWORDS}  {
  printf("keyword: %s\n", yytext);
  keywords[TOKEN_COUNT] = 1;
  keywords[LEXEME_COUNT] += 1;
}

[[:alpha:]_][[:alnum:]_]*  {
  printf("identifier: %s\n", yytext);
  identifiers[TOKEN_COUNT] = 1;
  identifiers[LEXEME_COUNT] += 1;
}

[[:digit:]]+ {
  printf("integer: %s\n", yytext);
  integers[TOKEN_COUNT] = 1;
  integers[LEXEME_COUNT] += 1;
}

[[:digit:]]+\.[[:digit:]]+ {
  printf("float: %s\n", yytext);
  floats[TOKEN_COUNT] = 1;
  floats[LEXEME_COUNT] += 1;
}

{UNARY_OPERATORS}  {
  printf("operator: %s\n", yytext);
  operators[TOKEN_COUNT] = 1;
  operators[LEXEME_COUNT] += 1;
}

{LEFT_PAREN} {
  printf("left paren: %s\n", yytext);
}

{RIGHT_PAREN} {
  printf("right paren: %s\n", yytext);
}

{LEFT_BRACKET} {
  printf("left bracket: %s\n", yytext);
}

{RIGHT_BRACKET} {
  printf("right bracket: %s\n", yytext);
}

{LEFT_CURLY_BRACKET} {
  printf("left curly bracket: %s\n", yytext);
}

{RIGHT_CURLY_BRACKET} {
  printf("right curly bracket: %s\n", yytext);
}

{COLON} {
  printf("colon bracket: %s\n", yytext);
}

{QUESTION_MARK} {
  printf("question mark: %s\n", yytext);
}

{TERMINATOR}  {
  printf("terminator: %s\n", yytext);
}

[[:punct:]] {
  printf("punctuation: %s\n", yytext);
  punctuation[TOKEN_COUNT] = 1;
  punctuation[LEXEME_COUNT] += 1;
}

[([:blank:]|\n)]  {}

%%

/***
  User Code Section
  yywrap() wraps the rules section
***/

int yywrap(){}

int main(){
  FILE *fp;
  char filename[50];
  printf("Enter the source code filename(<filename>.c): \n");
  //scanf("%s", filename);
  fp = fopen("input.txt", "r");

  // takes file pointer with the input
  yyin = fp;

  // main flex function which runs the rules section
  yylex();

  return 0;
}
