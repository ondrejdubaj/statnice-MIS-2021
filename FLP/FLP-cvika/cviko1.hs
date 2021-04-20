hello = putStrLn "Ahoj"

fakt :: Integer -> Integer
fakt 0 = 0
fakt n = n * fakt (n - 1)

