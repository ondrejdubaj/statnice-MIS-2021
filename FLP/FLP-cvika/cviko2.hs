import System.Environment
import System.IO
import System.Exit
import Data.List
import Data.Function
import Data.Char

{-andl :: [Bool] -> Bool
andl [s] = foldl (&&) True

andr :: [Bool] -> Bool
andr [s] = foldr (&&) True-}
type VarName = String

freeVars :: LExp -> [VarName]
freeVars le = fv [] where
	fv l (LVar v) = if elem l v then [] else [v]
	fv l (LApp e1 e2) = fv l e1 ++ fv l e2
	fv l (LAbs v e) = fv (v:l) e



main = do
    putStrLn "ahoj"