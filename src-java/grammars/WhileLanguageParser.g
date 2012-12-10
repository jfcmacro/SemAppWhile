parser grammar WhileLanguage;

options {
    tokenVocab=WhileLanguageLexer;
	k=1;
	language=Java;
    output=AST;
    ASTLabelType=CommonTree;
}


@header{
package co.edu.eafit.dis.semantics.whilelanguage.parser;
}

@rulecatch {
   catch (RecognitionException e ) {
      throw e;
   }
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
      | LCBRAKET! bexp RBRAKET!
      ;

opcomp : CEQUALS
       | CLET
       ;

