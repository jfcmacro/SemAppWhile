module Main where

import System.Environment(getArgs)
import Text.ParserCombinators.UU.Utils(runParser)
import Control.Monad(forM_,liftM)
import qualified Data.Map as Map
import AbsData
import SemBasicFunctions
import WhileParser(pStm,pAexp, pBexp)

test :: String -> IO ()
test s = do
  let out = runParser s pAexp s  
  putStrLn $ show out

processFile :: FilePath -> IO ()
processFile f = do 
  s <- readFile f
  let stm = runParser s pStm s
  putStrLn $ (show stm)
  let inh = Inh_Stm { state_Inh_Stm = Map.empty }
  putStrLn $ (show (sem_Stm stm Map.empty) )

main :: IO ()
main = do
  files <- getArgs
  forM_ files processFile