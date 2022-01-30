{-
                                                Set Comprehension
    - in mathematics the comprehension notation can be used to construct new sets from old sets
        {x^2 | x ∈  {1..5}}
        - this set {1,4,9,16,25} of all numbers x^2 such that x is an element of the set {1..5}
        - take an existing set 1-5 and process it using x as the holder and create a new set with the condition on the left
    
    - in haskell a similar comprehension notation can be used to construct new lists from old lists
        [x^2 | x <- [1..5]]
        - this list [1,4,9,16,25] of all numbers x^2 such that x is an element of the list [1..5]
        - this does the same thing
    - difference between a list and set is that in a set an order does not matter and duplicity does not matter
    - the order in a list matters as does how many times each value appears.
    - the expression x <- [1..5] is called a generator as it states how to generate values for x
    - comprehensions can have multiple generators comma separated
        - cartesian product example
        > [(x,y) | x <- [1,2,3], y <- [4,5]]
        [(1,4),(1,5),(2,4),(2,5),(3,4),(3,5)]
    - changing the order of the generators changes the order of the elements in the final list
        > [(x,y) | y <- [4,5], x <- [1,2,3]]
        [(1,4),(2,4),(3,4),(1,5),(2,5),(3,5)]
    - multiple generators are like nested loops with later generators as more deeply nested loops whose variables change value more frequently
        for y ranges 4-5 
            for x ranges 1-3
    - because x <- [1,2,3] is the last generator the value of the x component of each pair changes most frequently
-}

{-
                                                Dependant Generators
    - Later generators can depend on the variables that are introduced by earlier generators
        [(x,y) | x <- [1..3], y <- [x..3]]
        - the list [(1,1),(1,2),(1,3),(2,2),(2,3),(3,3)] of all pairs of numbers (x,y) such that x,y are elements of the list [1..3] and y >= x
    - using a dependant generator we can define the library function that concatenates a list of lists
        concat :: [[a]] -> [a]
        concat xss = [x | xs <- xss, x <- xs]

        For Example: 
            > concat [[1,2,3],[4,5],[6]]
            [1,2,3,4,5,6]
-}

{-
                                                Guards
    - List comprehensions can use guards to restrict the values produced by earlier generators
        [x | x <- [1..10], even x]
        - the list [2,4,6,8,10] of all numbers x such that x is an element of the list [1..10] and x is even

-}
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]
-- factors 15 == [1,3,5,15]

{-
    Example 1

    - using a guard we can define a function that maps a positive integer to its list of factors
    - a positive integer is prime if its only factors are 1 and itself. 
    - hence using factors we can define a function that decides if a number is prime
-}
prime :: Int -> Bool
prime n = factors n == [1,n]
-- For Example 
    -- > prime 15 == False
    -- > prime 7  == True

{-
    Example 2

    - Using a guard we can now define a function that returns the list of all primes up to a given limit
-}
primes :: Int -> [Int]
primes n = [x | x <- [2..n], prime x]

-- For Example
    -- > primes 40
    -- [2,3,5,7,11,13,17,19,23,29,31,37]

allprimes :: [Int]
allprimes = sieve [2..]

sieve :: [Int] -> [Int]
sieve [] = []
sieve (p:xs) = p : sieve [x | x <- xs, x `mod` p /= 0]

{-
                                                The Zip Function
    - a useful library function is zip which maps two lists to a list of pairs of their corresponding elements 
        zip :: [a] -> [b] -> [(a,b)]
            > zip['a','b','c'] [1,2,3,4]
            [('a',1),('b',2),('c',3)]
    - using zip we can define a function returing the list of all pairs of adjacent elements from a list
        pairs :: [a] -> [(a,a)]
        pairs xs = zip xs (tail xs)

        > pairs [1,2,3,4]
        [(1,2),(2,3),(3,4)]
    - you can use pairs to define a function that decides if the elements in a list are sorted or not
        sorted :: Ord a => [a] -> Bool
        sorted xs = and [x <= y | (x,y) <- pairs xs]

        > sorted [1,2,3,4]
        True
        > sorted [1,3,2,4]
        False
    - using zip we can define a function that returns the list of all positions of a value in a list
        positions :: Eq a => a -> [a] -> [Int]
        positions x xs = [i | (x', i) <- zip xs [0..], x == x']

        > positions 0 [1,0,0,1,0,1,1,0]
        [1,2,4,7]
-}
pairs :: [a] -> [(a,a)]
pairs xs = zip xs (tail xs)

sorted :: Ord a => [a] -> Bool
sorted xs = and [x <= y | (x,y) <- pairs xs]

positions :: Eq a => a -> [a] -> [Int]
positions x xs = [i | (x', i) <- zip xs [0..], x == x']

{-
                                                String Comprehension
    - string is a sequence of characters enclosed in double quotes
    - internally strings are represented as lists of characters
        "abc" :: String
        ['a','b','c'] :: [Char]
    - because strings are just special kinds of list any polymorphic function that operates on lists can also be applied to strings 
        > length "abcde"
        5
        > take 3 "abcde"
        "abc"
        > zip "abc" [1,2,3,4]
        [('a',1),('b',2),('c',3)]
    - list comprehensions can also be used to define functions on strings
    - example of counting how many times a character occurs in a string
        count :: Char -> String -> Int
        count x xs = length [x' | x' <- xs, x == x']

        > count 's' "Mississippi"
        4
-}
str = "abc" :: String
chars = ['a','b','c'] :: [Char]

count :: Char -> String -> Int
count x xs = length [x' | x' <- xs, x == x']

{-
    Exercise 1:
    A triple (x,y,z) of positive integers is called pythagorean if x^2 + y^2 = z^2
    Using a list comprehension define a function
        pyths :: Int -> [(Int,Int,Int)]
    that maps an integer n to all such triples with components in [1..n]

    For Example: 
        > pyths 5
        [(3,4,5),(4,3,5)]
-}
pyths :: Int -> [(Int,Int,Int)]
pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

{-
    Exercise 2:
    A positive integer is perfect if it equals the sum of all of its factors, excluding the number itself
    Using a list comprehension define a function
        perfects :: Int -> [Int]
    that returns the list of all oerfect numbers up to a given limit

    For Example:
        > perfects 500
        [6,28,496]
-}
-- define a perfect number
perfect :: Int -> Bool
perfect n = sum(init (factors n)) == n

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], perfect n]

perfects' :: Int -> [Int]
perfects' n = [x | perfect n, x <- [1 .. n]]

{-
    Exercise 3:
    The scalar product of two lists of integers xs and ys of length n is give by the sum of the products of the corresponding integers
    n-1
    Σ  (xs_i * ys_i)
    i = 0

    Σ == sum


    Using a list comprehension define a function that returns the scalar product of two lists.
-}

scalarprod :: [Int] -> [Int] -> Int
scalarprod xs ys = sum [xs !! i * ys !! i | i <- [0..n-1]]
                    where n = length xs

sp :: [Int] -> [Int] -> Int
sp xs ys = sum [x*y | (x,y) <- zip xs ys]