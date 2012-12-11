tree grammar FreeVars;

options {
    tokenVocab=WhileLanguageParser;
    language=Java;
    ASTLabelType=CommonTree;
}

@header {
package co.edu.eafit.dis.semantics.whilelanguage.walker;

import java.util.Set;
import java.util.HashSet;
}

@rulecatch {
   catch (RecognitionException e ) {
      throw e;
   }
}

whilelanguage returns [HashSet<String> fv]
    : ^(PROG a=stm)                       { $fv = $a.fv; }
    ;

stm returns [HashSet<String> fv]
    : ^(SEMICOLON s1=stm s2=stm)        { $s1.fv.addAll($s2.fv);
                                          $fv = $s1.fv;
                                        }
    | ^(ASSIGN ID a=aexp)               { $a.fv.remove($ID.text);
                                          $fv = $a.fv;
                                        }
    | ^(IF b=bexp s1=stm s2=stm)        { $s1.fv.addAll($s2.fv);
                                          $fv = $s1.fv;
                                        }
    | ^(WHILE b=bexp s=stm)             { $b.fv.addAll($s.fv);
                                          $fv = $b.fv;
                                        }
    | SKIP                              { $fv = new HashSet<String>(); }
    ;

aexp returns [HashSet<String> fv]
    : ^(PLUS  a=aexp b=aexp)    { $a.fv.addAll($b.fv);
                                  $fv = $a.fv;
                                }
    | ^(MINUS a=aexp b=aexp)    { $a.fv.addAll($b.fv);
                                  $fv = $a.fv;
                                }
    | ^(TIMES a=aexp b=aexp)    { $a.fv.addAll($b.fv);
                                  $fv = $a.fv;
                                }
    | INT                       { $fv = new HashSet<String>(); }
    | ID                        { $fv = new HashSet<String>();
                                  $fv.add($ID.text);
                                }
    ;

bexp returns [HashSet<String> fv]
    : ^(AND     a=bexp b=bexp)  { $a.fv.addAll($b.fv);
                                  $fv = $a.fv;
                                }
    | ^(MINUS   a=bexp)         { $fv = $a.fv; }
    | ^(CEQUALS a=aexp b=aexp)  { $a.fv.addAll($b.fv);
                                  $fv = $a.fv;
                                }
    | ^(CLET    a=aexp b=aexp)  { $a.fv.addAll($b.fv);
                                  $fv = $a.fv;
                                }
    | TRUE                      { $fv = new HashSet<String>(); }
    | FALSE                     { $fv = new HashSet<String>(); }
    ;
