parser grammar WhileLanguageParser;

options {
    tokenVocab=WhileLanguageLexer;
	k=1;
	language=Java;
    output=AST;
    ASTLabelType=CommonTree;
}

tokens {
    NEG;
    ASSIGN;
    SEQ;
    PROG;
}

@header{
package co.edu.eafit.dis.semantics.whilelanguage.parser;
}


@rulecatch {
   catch (RecognitionException e ) {
      throw e;
   }
}

whilelanguage 
    :  stm EOF -> ^(PROG stm)
    ;

stm : LBRACE! block RBRACE!
    | satom
	;

block
    : satom (SEMICOLON^ block)?
    ;

satom 
    : ID EQUALS aexp -> ^(ASSIGN ID aexp)
    | SKIP^
    | IF^  bexp  THEN! stm ELSE! stm 
    | WHILE^ bexp DO! stm 
    ;

aexp 
    : aterm (opsum^ aterm)*
    ;

opsum 
    : PLUS
    | MINUS
    ;

aterm
    : afact (opmul^ afact)*
    ;


opmul 
    : TIMES
    ;

afact
    : INT
    | ID
    | LPAREN! aexp RPAREN!
    ;

bexp
    : bterm (andop^ bterm)*
    ;

andop
    : AND
    ;

bterm
    : MINUS batom -> ^(NEG batom)
    | batom
    ;

batom
    : TRUE
    | FALSE
    | aexp opcomp^ aexp
    | LCBRAKET! bexp RBRAKET!
    ;

opcomp
    : CEQUALS
    | CLET
    ;

