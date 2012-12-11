lexer grammar WhileLanguageLexer;

options {
	language = Java;
}


@lexer::header{
package co.edu.eafit.dis.semantics.whilelanguage.parser;
}

PLUS      : '+';
MINUS     : '-';
TIMES     : '*';
SEMICOLON : ';';
LPAREN    : '(';
RPAREN    : ')';
LCBRAKET  : '[';
RBRAKET   : ']';
LBRACE    : '{';
RBRACE    : '}';
EQUALS    : '=';
AND       : '&&' ;
CEQUALS   : '==';
CLET      : '<=';
IF        : 'if';
THEN      : 'then';
ELSE      : 'else';
TRUE      : 'true';
FALSE     : 'false';
WHILE     : 'while';
DO        : 'do';
SKIP      : 'skip';
ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;
INT :	'0'..'9'+;
WS  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;
