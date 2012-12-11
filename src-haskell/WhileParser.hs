{-#
  LANGUAGE FlexibleContexts,
  TypeSynonymInstances,
  MultiParamTypeClasses,
  Rank2Types,
  FlexibleContexts,
  NoMonomorphismRestriction,
  CPP
  #-}

module WhileParser(pStm,pAexp,pBexp) where

import AbsData
import Text.ParserCombinators.UU
import Text.ParserCombinators.UU.Utils
import Text.ParserCombinators.UU.BasicInstances


-- Helper parsers
-- All of them taken from the Text.ParserCombinators.UU.Demo

pVarId  = (:) <$> pLower <*> pList pIdChar `micro` 1 <* spaces
pIdChar = pLower <|> pUpper <|> pDigit


pKey keyw = pToken keyw `micro` 1 <* spaces
spaces :: Parser String
spaces = pMunch (`elem` " \t\n")

pEqual = pSym '=' `micro` 1 <* spaces

pCEqual = pKey "==" `micro` 1 <* spaces
pCLessT = pKey "<=" `micro` 1 <* spaces

pInt :: Parser Int
pInt = read <$> pList1 (pRange ('0','9')) `micro` 1 <* spaces

pAndSym = pKey "&&" `micro` 1 <* spaces
-- All our parsers

-- Statement Parser
pOpSc :: Parser (Stm -> Stm -> Stm)
pOpSc = SSeq <$ pSym ';' `micro` 1 <* spaces

pStm :: Parser Stm
pStm =  pStm'
    <|> pBraces pBlock

pBlock :: Parser Stm
pBlock = pChainr pOpSc pStm'

pStm' :: Parser Stm
pStm' = Assign <$> pVarId <*> (pEqual *> pAexp)
     <|> Skip   <$  pKey "skip"
     <|> If    <$> (pKey "if" *> pBexp )
               <*> (pKey "then" *> pStm)
               <*> (pKey "else" *> pStm)
     <|> While <$> (pKey "while" *> pBexp)
               <*> (pKey "do" *> pStm)

-- Arithmetic expression parser
pOpMul :: Parser (Aexp -> Aexp -> Aexp)
pOpMul = Mul <$ pSym '*' `micro` 1 <* spaces

pOpSum :: Parser (Aexp -> Aexp -> Aexp)
pOpSum = Add <$ pSym '+' `micro` 1 <* spaces
      <|> Sub <$ pSym '-' `micro` 1 <* spaces

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
pOpAnd = And <$ pAndSym

pOpCmp :: Parser (Aexp -> Aexp -> Bexp)
pOpCmp = Eqq <$ pCEqual
      <|> Lqt <$ pCLessT

pBexp :: Parser Bexp
pBexp = pChainl pOpAnd pBexp'

pBexp' :: Parser Bexp
pBexp' =  Neg <$> (pSym '-' *> pBexp'')
      <|> pBexp''

pBexp'' :: Parser Bexp
pBexp'' = BTrue   <$  pKey "true"
      <|> BFalse <$  pKey "false"
      <|> pAexp <**> pOpCmp <*> pAexp
      <|> pBrackets pBexp


