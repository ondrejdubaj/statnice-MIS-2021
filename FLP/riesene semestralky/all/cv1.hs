faktorial 0 = 1
faktorial n = 
	if n < 0
		then error "Zaporny cislo"
		else faktorial (n-1) * n

fib 0 = 0
fib 1 = 1
fib n = (fib (n-1)) + (fib (n-2))

fib2 n = f 0 1 n
	where
		f x _ 0 = x
		f a b n = f b (a + b) (n - 1)	

spoj [] ys = ys
spoj (x:xs) ys = x:(spoj xs ys)

-- obrat [] = 
-- obrat (x:xs) = (obrat xs):x

addList :: Num a => a -> [a] -> [a]
addList n = map (+n)

incList :: [Integer] -> [Integer]
incList = addList 1

andl = foldl (&&) True

andr = foldr (&&) True

--andl $ repeat False
--andr $ repeat False

fspoj lx ly = foldr (:) ly lx
