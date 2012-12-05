grammar WhileLanguage;

options {
	k = 1;
	language = Java;
}

tokens {
	PLUS      = '+';
	MINUS     = '-';
	TIMES     = '*';
	SEMICOLON = ';';
	LPAREN    = '(';
	RPAREN    = ')';
    LCBRAKET  = '[';
    RBRAKET   = ']';
    LBRACE    = '{';
    RBRACE    = '}';
	EQUALS    = '=';
	AND       = '&&' ;
    CEQUALS   = '==';
    CLET      = '<=';

	// Keywords
	IF        = 'if';
	THEN      = 'then';
	ELSE      = 'else';
	TRUE      = 'true';
	FALSE     = 'false';
    WHILE     = 'while';
    DO        = 'do';
    SKIP      = 'skip';
}

whilelanguage :  stm EOF
		;

stm : satom (options {greedy=true;}: SEMICOLON stm)?
	;

satom : ID EQUALS aexp
      | SKIP 
      | IF  bexp  THEN stm ELSE stm
      | WHILE bexp DO stm
      | LBRACE stm RBRACE
	  ;

aexp : aterm (opsum aterm)*
     ;

opsum : PLUS
      | MINUS
      ;

aterm  : afact (opmul afact)*
       ;


opmul : TIMES
      ;

afact : INT
      | ID
      | LPAREN aexp RPAREN
      ;

bexp : bterm (andop bterm)* 
     ;

andop : AND
      ;

bterm : MINUS batom
      | batom
      ;

batom : TRUE
      | FALSE
      | aexp opcomp aexp
      | LCBRAKET bexp RBRAKET
      ;

opcomp : CEQUALS
       | CLET
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

END	:
	;

