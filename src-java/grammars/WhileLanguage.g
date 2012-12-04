grammar WhileLanguage;

whilelanguage 
	:	 aexp EOF
	;
	
aexp 	:	term (('+' | '-') term)*
	;

term	:	fact ('*' fact)*
	;

fact	:	INT
	|	ID
	|	'(' aexp ')'
	;
	
bexp	:	atom ('&' atom)* EOF
	;

atom	:	'true' 
	|	'false'
	|	INT (('+' | '-') term)* ('*' fact)* (('=' | '<=') aexp)
	|	ID  (('+' | '-') term)* ('*' fact)* (('=' | '<=') aexp)
	|	'-' bexp
	|       '(' atom ')'
	;
	
//	|	parens
//	;
	
// parens	:	'(' parens ')'
//	|	(INT|ID) (('+' | '-') term)* ('*' fact)*
//	|       ('true' | 'false') ('&' atom)*
//	|	'-' bexp
//	;
	
ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;

INT :	'0'..'9'+
    ;

WS  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;

