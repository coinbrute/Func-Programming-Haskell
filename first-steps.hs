{-
    The Glasgow Haskell Compiler

    A compiler translates code into lower level language where a machine cna run it directly 
    A translater/interpreter runs the code directly

    GHC is the leading implementation of Haskell
    comprised of compiler and interpreter

    Start by opening terminal/cmd and typing 'ghci'

    can be used as simple expression evaluator in terminal 
-}

{-
    The Standard Prelude 

    - Haskell comes with a large number of standard library funciton.
    - In addition to the familiar numeric funcitons such as + * there are manu for lists
    - select first element of a list
        head [1,2,3,4,5]
        1
    - remove the first element of a list
        tail [1,2,3,4,5]
        [2,3,4,5]
    - select the nth element of a list
        [1,2,3,4,5] !! 2
        3
    - select the first n elements of a list
        take 3 [1,2,3,4,5]
        [1,2,3]
    - remove the first n elements from a list
        drop 3 [1,2,3,4,5]
        [4,5]
    - calculate the length of a list
        length [1,2,3,4,5]
        5
    - calculate the sum of a list of numbers 
        sum [1,2,3,4,5]
        15
    - calculates the product of a list of numbers
        product [1,2,3,4,5]
        120
    - append two lists 
        [1,2,3] ++ [4,5]
        [1,2,3,4,5]
    - reverse a list
        reverse [1,2,3,4,5]
        [5,4,3,2,1]
-}

{-
    Function Application

    - in mathematics function applicaiton is denoted using parentheses
    - multiplication is often denoted using spaces
        f(a,b) + c d

    - in haskell function application is denoted using spaces 
    - multiplication is denoted using *
        f a b + c*d
    
    - function application is assumed to have higher priority than all other operators
        f a + b
        - means (f a) + b, rather than f(a + b)
        - haskell chooses (f a) + b
    
                    Math            Haskell
                    f(x)            f x
                    f(x,y)          f x y
                    f(g(x))         f (g x)
                    f(x,g(y))       f x (g y)
                    f(x)g(y)        f x * g y

-}

{-
    Haskell Scripts 

    - new functions are defined within a script 
    - a script is a text file comprising a sequence of definitions 
    - by convention haskell scripts have a .hs suffix on their filename 
    
    Heading over to test.hs for my Exercise 1. 
-}

{-
    Useful GHCi Commands

    - all can be abbreviated to first letter

    Command             Meaning
    :load name          load script name
    :reload             reload current script
    :set editor name    set editor to name
    :edit name          edit script name
    :edit               edit current script
    :type expr          show type of expr
    :?                  show all commands
    :quit               quit GHCi   
-}

{-
    Naming Requirements

    - function and argument names must begin with a lower-case letter
        - myFun fun1 arg_2 x'
    - capital letters are reserved for Types
    - by convention list arguments usually have an s suffix on their name 
        - xs ns nss <-- more s's usually means nested 
-}

{-
    The Layout Rule

    - in a sequence of definitions each definition must begin in precisely the same column
    GOOD            BAD       
    a = 10          a = 10
    b = 20           b = 20
    c = 30          c = 30

    - avoids the need for explicit syntax to indicate the grouping of definitions
    - allows for implicit grouping
            a = b + c
                where
                    b = 1
                    c = 2
            d = a * 2   
-}

{-
    Exercise 2

    Correct the syntax below
    N = a 'div' length xs
        where
            a = 10
           xs = [1,2,3,4,5]
-}
n = a `div` length xs
    where
        a = 10
        xs = [1,2,3,4,5]

{-
    Exercise 3

    Show how the library function 'last' that selects the last element of a list can be defined 
    using the functions introduced in this lecture
-}
last' xs = head (reverse xs)

{-
    Exercise 4

    Think of another possible definition for 'last'
-}
last'' xs = xs !! (length xs - 1)

{-
    Exercise 5

    Define init using functions introduced in this lecture two different ways
    - init removes the last element from a list
-}
init' xs = take (length xs - 1) xs

init'' xs = reverse (tail (reverse xs))