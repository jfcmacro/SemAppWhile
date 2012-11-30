module Main where

import System.Environment(getArgs)
import Text.ParserCombinators.UU.Utils(runParser)
import Control.Monad(forM_,liftM)
import AbsData
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

main :: IO ()
main = do
  putStrLn "Prueba pAexp"
  test "12343 + 2113"
  files <- getArgs
  forM_ files processFile