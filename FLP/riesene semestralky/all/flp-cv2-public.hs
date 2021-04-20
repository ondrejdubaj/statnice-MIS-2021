import IO

--FLP 2012 cviceni 2.

data Teplota
	= Nula
	| Kelvin Float
	| Celsius Float
	deriving Show

toKelvin :: Teplota -> Float	
toKelvin Nula = 273.15
toKelvin (Kelvin x) = x
toKelvin (Celsius x) = x + 273.15

-- Priklad zavolani:
-- toKelvin (Kelvin 2)
-- toKelvin Nula


data Seznam a
	= Prazdny
	| Kons a (Seznam a)
	deriving Show

--priklad prace s datovym typem (Seznam a)
hlavicka :: Seznam a -> a
hlavicka Prazdny = error "Prazdny seznam nema hlavicku."
hlavicka (Kons h _) = h

--Ukol 1.
data Vector a = Vec Int [a] deriving Show

-- Inicializace vektoru
initVector :: [a] -> Vector a
initVector l = Vec (length l) l

-- Priklad zavolani:
-- initVector [1,2]

-- Num a (definuje typ)
dotProd :: Num a => Vector a -> Vector a -> a
-- jde o skalarni soucin dvou seznamu neboli vektoru (foldr nebo sum)
dotProd (Vec l1 v1) (Vec l2 v2) =
  if l1 /= l2
    then error "Nesouhlasi delka."
    else sum $ zipWith (*) v1 v2

-- Priklad zavolani
-- dotProd (initVector [1..3]) (initVector [4..6])
    
    
data Student = Student
	{ jmeno :: String
	, stip :: Int
	, phd :: Bool
	} deriving Show

-- napisu do konzole	
-- Student {jmeno = "standa", stip = 6700, phd = True}

--Ukol 5.
-- zdvojnasobit plat
phdPayRise :: [Student] -> [Student]
phdPayRise = map ppr where
			ppr s = 
			  if phd s
			    then Student (jmeno s) (2*stip s) True
			    else s
			    
-- Priklad zavolani
-- phdPayRise [Student {jmeno = "standa", stip = 6700, phd = True}]

			    
--Ukol 6.


-- typovy konstruktor
type VarString = String


-- datovy konstruktor
data LExp = LVar VarString
	| LApp LExp LExp
	| LAbs String LExp
	deriving Show

	
-- lambda promena
-- lambda aplikace
-- lambda abstrakce
freeVars :: LExp -> [String]
freeVars le = fv le [] 
  where
    fv (LVar v) l = if elem v l then [] else [v]
    fv (LApp e1 e2) l = fv e1 l ++ fv e2 l
    fv (LAbs v e) l = fv e (v:l)

-- Takhle to vypada v lambda kalkul:
-- \ = Var
--   | \x.e
--   | (e e)
  


--ukazka case ... of
delka s =
	case s of
		[] -> 0
		_:xs -> 1 + delka xs

--"databaze" otcu		
otec :: String -> Maybe String
otec "Karel" = Just "Evzen"
otec "Evzen" = Just "Dobromil"
otec "Dobromil" = Just "Franta"
otec _ = Nothing

otcuvOtec1 x = 
      case otec x of
	      Nothing -> Nothing
	      Just y -> otec y

--otcuvOtec2 x = ...

otcovaOtceOtec1 x = 
      case otec x of
	   Nothing -> Nothing
	   Just y ->
		    case otec y of
			Nothing -> Nothing
			Just z -> otec z
--otcovaOtceOtec2 x = ...






psychiatr = do
	      l <- getLine
	      if length l == 0
		  then return ()
		  else do {
		    putStrLn $ "Vy tedy tvrdite: " ++ l;
		    psychiatr;
		  }  
		  -- else do                 -- > nebo
		  --    putStrLn $ "Vy tedy tvrdite: " ++ l
		  --    psychiatr

-- Priklad zadani:
psychiatr (a dam enter a napisu vetu a zas dam enter a on se ukonci)
	
--countLines file = do
--	...
			
