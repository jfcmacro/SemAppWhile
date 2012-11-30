module Main where

import System.Environment(getArgs)
import Text.ParserCombinators.UU.Utils(runParser)
import Control.Monad(forM_)
import AbsData
import WhileParser(pStm)

processFile :: FilePath -> IO ()
processFile f = do 
  s <- readFile f
  let stm = runParser s pStm s
  putStrLn $ (show stm)

main :: IO ()
main = do
  files <- getArgs
  forM_ files processFile