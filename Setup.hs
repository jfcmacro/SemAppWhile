module Main where 

import Distribution.Simple (defaultMainWithHooksArgs)
import Distribution.Simple.UUAGC (uuagcUserHook)
import System.Environment (getArgs)

main :: IO ()
main = getArgs >>= defaultMainWithHooksArgs uuagcUserHook