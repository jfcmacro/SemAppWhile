{-# LANGUAGE FlexibleContexts,
             TypeSynonymInstances,
             MultiParamTypeClasses,
             Rank2Types, 
             FlexibleContexts, 
             NoMonomorphismRestriction,
              CPP  #-}

module WhileParser(pStm) where

import AbsData
import Text.ParserCombinators.UU
import Text.ParserCombinators.UU.Utils
import Text.ParserCombinators.UU.BasicInstances


-- Helper parsers
-- All of them taken from the Text.ParserCombinators.UU.Demo

pVarId  = (:) <$> pLower <*> pList pIdChar
pIdChar = pLower <|> pUpper <|> pDigit <|> pAnySym "='"

pKey keyw = pToken keyw `micro` 1 <* spaces
spaces :: Parser String
spaces = pMunch (`elem` " \n")

pInt :: Parser Int
pInt = read <$> pList1 (pRange ('0','9'))

-- All our parsers

-- Statement Parser
-- I don't like this parser
pOpSc :: Parser (Stm -> Stm -> Stm)
pOpSc = SSeq <$ pSym ';'

pStm :: Parser Stm
pStm =  pChainr pOpSc pStm'

pStm' :: Parser Stm
pStm' = Assign <$> pVarId <* pSym '=' <*> pAexp
     <|> Skip  <$  pKey "skip"
     <|> If    <$> (pKey "if" *> pBexp ) 
               <*> (pKey "then" *> pStm) 
               <*> (pKey "else" *> pStm)
     <|> While <$> (pKey "while" *> pBexp)  
               <*> (pLBrace *> pStm <* pRBrace)

-- Arithmetic expression parser
pOpMul :: Parser (Aexp -> Aexp -> Aexp)
pOpMul = Mul <$ pSym '*'

pOpSum :: Parser (Aexp -> Aexp -> Aexp)
pOpSum = Add <$ pSym '+'
      <|> Sub <$ pSym '-'

pAexp :: Parser Aexp
pAexp = pChainr pOpSum pAexp'

pAexp' :: Parser Aexp
pAexp' =  pChainr pOpMul pAexp''

pAexp'' :: Parser Aexp
pAexp'' = ANum <$> pInt
       <|> AVar <$> pVarId
       <|> pParens pAexp  

-- Boolean expresion parser
pOpAnd :: Parser (Bexp -> Bexp -> Bexp)
pOpAnd = And <$ pSym '&'

pBexp :: Parser Bexp
pBexp = pChainr pOpAnd pBexp'

pBexp' :: Parser Bexp
pBexp' = BTrue <$ pKey "true"
      <|> BFalse <$ pKey "false"
      <|> Eqq   <$> pAexp <* pSym '='  <*> pAexp
      <|> Lqt   <$> pAexp <* pKey "<=" <*> pAexp
      <|> Neg   <$> (pSym '-' *> pBexp)
      <|> pParens pBexp


