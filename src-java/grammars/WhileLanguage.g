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

atom	: 'true' 
	| 'false'
	| aexp (('=' | '<=') aexp)?
	| '-' bexp
	| '{' bexp '}'
	;
	
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

