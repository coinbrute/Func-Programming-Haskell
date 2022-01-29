{-
                                    Conditional Expressions
    - as in most programming languages functions can be defined using conditional expressions
    - if-then-else
        abs :: Int -> Int
        abs n = if n >= 0 then n else (-n)
        - abs takes an integer n and returns n if it is non negative and -n otherwise
        - you don't need to explicitly write return
    - conditional expressions can be nested
        signum :: Int -> Int
        signum n = if n < 0 then (-1) else
                        if n == 0 then 0 else 1
    - in Haskell, conditional expressions must always have an else branch, which avoids any possible ambiguity problems with nested conditionals
-}
abs :: Int -> Int 
abs n = if n >= 0 then n else (-n)

signum :: Int -> Int 
signum n = if n < 0 then (-1) else
            if n == 0 then 0 else 1

{-
                                    Guarded Equations
    - an alternative to conditionals
    - functions can also be defined using guarded equations
        abs n 
            | n >= 0      = n
            | otherwise   = -n
        - same as before but with guarded equations
    -main benefit is they can be used to make definitions involving multiple conditions easier to read
        signum n
                | n < 0     = -1
                | n == 0    = 0
                | otherwise = 1
    - the catch all condition otherwise is defined in the prelude by othewise = True
-}
abs' :: Int -> Int
abs' n
    | n >= 0    = n
    | otherwise = -n

signum' :: Int -> Int
signum' n
        | n < 0     = -1
        | n == 0    = 0
        | otherwise = 1

{-
                                Pattern Matching
    - Many functions have a particularly clear definition using pattern matching on their arguments
        not :: Bool -> Bool
        not False = True
        not True  = False
        - not maps False to True and True to False
    - functions can often be defined in many different ways using pattern matching 
        (&&) :: Bool -> Bool -> Bool
        True  && True  = True
        True  && False = False
        False && True  = False
        False && False = False
        - can be defined more compactly
            True && True = True
            _ && _ = False
    - '_' is a wildcard pattern to catch all argument values and multiple underscores will match different things
        - however the following definition is more efficient because it avoids evaluating the second argument if the first argument is false
            True  && b = b
            False && _ = False
    - patterns are matched in order from top to bottom
    - the following example always returns false
        _    && _    = False
        True && True = True
    - Patterns may not repeat variables 
    - the following definition will give an error
        b && b = b
        _ && _ = False
-}
not :: Bool -> Bool
not True  = False
not False = True

-- least efficient
-- (&&) :: Bool -> Bool -> Bool
-- -- True  && True  = True
-- -- -- True  && False = False
-- -- -- False && True  = False
-- -- -- False && False = False

-- better
-- (&&) :: Bool -> Bool -> Bool
-- True  && True  = True
-- _     && _     = False

-- best
-- (&&) :: Bool -> Bool -> Bool
-- True  && b = b
-- False && _ = False

{-
                                        List Patterns
    - Internally every non-empty list is constructed by repeated use of an operator (:) called "cons" that adds an element to the start of a list
        [1,2,3,4] == 1:(2:(3:(4:[]))) == 1:2:3:4:[]
    - functions on lists can be defined using x:xs patterns
    - cons operator is not just used for constructions but for deconstructions 
        head :: [a] -> a
        head (x:_) = x

        tail :: [a] -> [a]
        tail (_:xs) = xs
        - head and tail map any non-empty list to its first and remaining elements
    - x:xs patterns only match non-empty lists
        > head []
        *** Exceptions: empty list
    - x:xs patterns must be parenthesised, because application has priority over (:) 
    - the following gives an error because there are two operators on the left side of definition, the space between head and x (function application which has priority) and cons operator between x and underscore.
        head x:_ = x
-}

listPattern1 = [1,2,3,4]
listPattern2 = 1:(2:(3:(4:[])))
listPattern3 = 1:2:3:4:[]

head' :: [a] -> a
head' (x:_) = x

tail' :: [a] -> [a]
tail' (_:xs) = xs

{-
                                    Lambda Expressions
    - Functions can be constructed without naming the functions by using lambda expressions
        \x -> x + x
        - the nameless function that takes a number x and returns the result x + x
    - the symbol λ is the greek letter lambda and is typed at the keyboard as a backslash '\'
    - in mathematics nameless functions are usually denoted using the ↦ symbol or mapsto as in x ↦ x + x 
    - in Haskell the use of the λ symbol for nameless functions comes from the lambda calculus
    - lambda calculus is the theory of funcitons on which haskell is based

    Why are these useful?

    - lambda expressions can be used to give a formal meaning to funcitons defined using currying
    - For example
        add :: Int -> Int -> Int
        add x y = x + y
    means
        add :: Int -> (Int -> Int)
        add = \x -> (\y -> x + y)
        - this says add is a function that takes an integer 
        - this returns a functions that takes an integer
        - this second function returns the sum of both integers
    - lambda expressions can be used to avoid naming functions that are only referenced once
                odds n = map f [0..n-1]
                        where 
                            f x = x * 2 + 1
        - this can be simplified using lambdas
                odds n = map (\x -> x*2 + 1) [0..n-1]
-}

lambda = \x -> x + x

addNoLambda :: Int -> Int -> Int
addNoLambda x y = x + y

addWithLambda :: Int -> (Int -> Int)
addWithLambda = \x -> (\y -> x + y)

oddsUsingWhereFunc :: Int -> [Int]
oddsUsingWhereFunc n = map f [0..n-1]
                        where
                            f x = x*2 + 1

oddsUsingLambda :: Int -> [Int]
oddsUsingLambda n = map (\x -> x*2 + 1) [0..n-1]

{-
                                Operator Sections
    - an operator written between its two args can be converted into a curried funcitons written before its two args by using parentheses
    - For Example: 
        > 1+2
        3

        > (+) 1 2
        3
    - this convention also allows one of the args of the operator to be included in the parentheses
        > (1+) 2
        3
        
        > (+2) 1
        3
    - in general if + is an operator then functions of the form (⊕), (x⊕) and (⊕y) are called sections

    Why are these useful?

    - useful functions can sometimes be constructed in a simple way using sections 
        - (1+) - successor function 
        - (1/) - reciprocation function
        - (*2) - doubling function
        - (/2) - halving function
-}
three   = 1+2
three'  = (+) 1 2
three'' = (1+) 2
three''' = (+2) 1

{-
    Exercise 1 - Consider a functions safetail that behaves in the same way as tail except that safetail maps the empty list to the empty list, whereas tail gives an error in this case. 
    - Define safetail using:
        - a conditional expression;
        - guarded equations;
        - pattern matching;

    - tail returns everything except first value in list
    Hint: the library funcitons null :: [a] -> Bool can be used to test if a list is empty
-}
-- conditional
safeTailCond :: [a] -> [a]
safeTailCond xs = if null xs then [] else tail xs 
-- gaurded equations
safeTailGrd :: [a] -> [a]
safeTailGrd xs 
            | null xs   = []
            | otherwise = tail xs
-- pattern matching
safeTailPtn :: [a] -> [a]
safeTailPtn [] = []
safeTailPtn (_:xs) = xs


{-
    Exercise 2 - Give three possible definitions for the logical or operator (||) using pattern matching.
-}
-- Option 1
(||) :: Bool -> Bool -> Bool
False || False = False
True  || True  = True
True  || False = True
False || True  = True

-- Option 2
-- (||) :: Bool -> Bool -> Bool
-- False || False  = False
-- _     || _      = True

-- Option 3
-- (||) :: Bool -> Bool -> Bool
-- False || b    = b
-- True  || _    = True


{-
    Exercise 3 - Redefine the following version of (&&) using conditionals rather than patterns:
        True && True = True
        _    && _    = False

    Hint: Will probably need nested conditionals
-}

(&&&) :: Bool -> Bool -> Bool
(&&&) a b = if a == True && b == True then True else False

{-
    Exercise 4 - Redefine the following version of (&&) using conditionals rather than patterns:
        True  && b = b
        False && _ = False

    Hint: Should only require a single if-then-else
-}   
(&&&&) :: Bool -> Bool -> Bool
(&&&&) a b = if a == True && b then b else False