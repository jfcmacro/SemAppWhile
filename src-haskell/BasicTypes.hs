module BasicTypes(Var, 
                  State,
                  lookupState,
                  Variables) where

import qualified Data.Map as Map
import qualified Data.Set as Set

type Var       = String
type State     = Map.Map Var Int
type Variables = Set.Set Var

lookupState  :: Var -> State -> Int
lookupState v s = maybe 0 id $ Map.lookup v s 

