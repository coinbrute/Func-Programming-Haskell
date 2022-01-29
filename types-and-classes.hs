{-
                                    Types and Classes 
    
    - two of the fundemental ideas in Haskell
    - a type is a name for a collection of related values 
        - for example, in Haskell the basic type Bool contains the two logical values True and False
-}

{-
                                    Type Errors
    
    - Applying a function to one or more arguments of the wrong type is called a type error
        >1 + False
        > error ...
    - 1 is a number and False is a logical value, but + requires two numbers

-}

{-
                                    Types in Haskell
    
    - if evaluating an expression e would produce a value of type t, then e has type t, written 
        e :: t
    - every well formed expression has a type, 
    - this can be automatically calculated at compile time using a process called type inference
    - best practice to define types
    - all type errors are found at compile time 
    - makes programs safer and faster by removing the need for type checks at run
    - in GHCi the :t/:type command calcs the type of an expression without evaluating it
        > not False
        True
        > :type not False
        not False :: Bool
-}

{-
                                    Basic Types
    - Haskell has a number of basic types
    - Bool -> logical values
    - Char -> single characters in single quotes ''
    - String - string of characters in double quotes ""
    - Int - integer 64 bit numbers 
    - Float - floating- point numbers 
-}

{-
                                    List Types
    - a list is a sequence of values of the same type
        [False, True, False] :: [Bool]
        ['a','b','c','d'] :: [Char]
    - in general [t] is the type of lists with elements of type t
    - no constraints on type t 
    - the type of a list says nothing about its length
    - the type of the elements is unrestricted 
        - we can have lists of lists, lists of tuples etc.
        [['a'], ['b','c']] :: [[Char]]
-}
listOfBools    = [False, True, False] :: [Bool]
listOfChars    = ['a','b','c','d'] :: [Char]
nestedCharList = [['a'], ['b','c']] :: [[Char]]

{-
                                    Tuple Types
    - A tuple is a sequence of values of different types
        (False, True) :: (Bool, Bool)
        (False, 'a', True) :: (Bool, Char, Bool)
    - in general, (t1,t2..tn) is the type of n-tuples whose ith components have type ti for any i in 1..n
    - the type of a tuple tells you its size and types
        (False, True) :: (Bool, Bool)
        (False, True, False) :: (Bool, Bool, Bool)
    - the type of the components is unrestricted
        ('a', (False, 'b')) :: (Char, (Bool, Char))
        (True, ['a','b']) :: (Bool, [Char])
-}
boolTuple       = (False, True) :: (Bool, Bool)
multiTypeTuple  = (False, 'a', True) :: (Bool, Char, Bool)
tupleOfTuple    = ('a', (False, 'b')) :: (Char, (Bool, Char))
tupleOfList     = (True, ['a','b']) :: (Bool, [Char])
{-    
                                    Function Types
    - a function is a mapping from values of one tpye to values of another type
        not :: Bool -> Bool
        even :: Int -> Bool
    - in general, t1 -> t2 is the type of functions that map values of type t1 to values to type t2
    - no constraints on what types t1 and t2 are
    - the arrow -> is typed as '-' and '>'
    - the argument and result types are unrestricted 
    - functions with multiple arguments or results are possible using lists or tuples
        add :: (Int, Int) -> Int
        add (x, y) = x + y

        zeroto :: Int -> [Int]
        zeroto n = [0..n]
-}
add :: (Int, Int) -> Int
add (x, y) = x + y

zeroto :: Int -> [Int]
zeroto n = [0..n]

{-
                                    Curried Functions
    - Functions with multiple arguments are also possible by returning funcitons as results
        add' :: Int -> (Int -> Int)
        add' x y = x + y
    - add' takes an integer x and returns a function add' x
    - in turn this function takes an integer y and returns the result x + y
    - add and add' produce the same final result
    - but add takes its two arguments at the same time whereas add' takes them one at a time
        add :: (Int, Int) -> Int
        add' :: Int -> (Int -> Int)
    - Functions that take their arguments one at a time are called curried functions after the work of Haskell Curry on such funcitons
    - Functions with more than two arguments can be curried by returning nested functions
        mult :: Int -> (Int -> (Int -> Int))
        mult x y z = x*y*x
    - mult takes an dinteger x and returns a function mult x
    - this in turn takes and integer y and returns a funciton mult x y 
    - this finally takes an integer z and returns the result x * y * z

    - Curried functions are more flexible than funcitons on tuples 
        - useful funcitons can often be made by partially applying a curried function
        add' 1 :: Int -> Int
        take 5 :: [Int] -> [Int]
        drop 5 :: [Int] -> [Int]
-}
add' :: Int -> (Int -> Int)
add' x y = x + y

add'' :: (Int, Int) -> Int
add'' (x, y) = x + y

add''' :: Int -> (Int -> Int)
add''' x y = x + y

mult :: Int -> (Int -> (Int -> Int))
mult x y z = x*y*x

{-
                                    Currying conventions
    - to avoid excess parentheses when using curried functions follow tow simple conventions 
    - the arrow -> associates to the right
        - Int -> Int -> Int -> Int
        - Means more like this Int -> (Int -> (Int -> Int))
    - as a consequence it is then natural for function application to associate to the left
        mult x y z
        - means ((mult x)y)z
    - unless tupling is explicitly required all function sin Haskell are normally defined in curried form
-}

{-   
                                    Polymorphic Functions
    - a function is called polymorphic ("of many forms") if its type contains one or more type variables 
        length :: [a] -> Int
        - for any type a length takes a list of values of type a and returns and integer
    - type variables can be instantiated to different types in different circumstances
        > length [False, True] -- a == Bool
        2
        > length [1,2,3,4] -- a == Char
        4
    - type variables must begin with a lower-case letter and are usually named a,b,c, etc
    - Many of the functions defined in the standard prelude are polymorphic 
        fst :: (a,b) -> a
        head :: [a] -> a
        take :: Int -> [a] -> [a]
        zip :: [a] -> [b] -> [(a,b)]
        id :: a -> a
-}

{-   
                                    Overloaded Function
    - a polymorphic funciton is called overloaded if its type contains one or more class constraints 
        (+) :: Num a => a -> a -> a
        - for any numeric type a, (+) takes two values of type a and returns a value of type a.
    - constrained type variables can be instantiated to any types that satisfy the constraints
        > 1 + 2 -- a == Int
        3
        > 1.0 + 2.0 -- a == Float
        3.0
        > 'a' + 'b' -- Char is not a numeric type
        ERROR
    - Haskell has a number of type classes 
        - Num - numeric types
            (+) :: Num a => a -> a -> a
        - Eq - equality types
            (==) :: Eq a => a -> a -> Bool
        - Ord - ordered types
            (<) :: Ord a => a -> a -> Bool
    
                                Hints and Tips
    - when defining a new function in Haskell it is useful to begin by writing down its type
    - within a script it is good practice to state the type of every new function defined
    - when stating the types of polymorphic funcitons that use numbers, equality or orderings, take care to include the necessary class constraints
    
-}

{- 
    Exercise 1 - Define the types for the following values
    ['a','b','c'] :: [Char]
    ('a','b','c') :: (Char, Char, Char)
    [(False,'0'),(True,'1')] :: [(Bool, Char)]
    ([False,True],['0','1']) :: ([Bool], [Char])
    [tail,init,reverse] :: [[a] -> [a]]
-}
charList :: [Char]
charList = ['a', 'b', 'c']

tuple :: (Char, Char, Char)
tuple = ('a', 'b', 'c') 

listOfTuples :: [(Bool, Char)]
listOfTuples = [(False, '0'), (True, '1')]

tupleOfLists :: ([Bool], [Char])
tupleOfLists = ([False, True], ['0', '1'])

listOfFuncs :: [[a] -> [a]]
listOfFuncs = [tail, init, reverse]

{-
    Exercise 2 - Define the types of the following functions
    
    second :: [a] -> a
    second xs = head (tail xs)
    swap :: (a,b) -> (b,a)
    swap (x,y) = (y,x)
    pair :: x -> y -> (x,y)
    pair x y = (x,y)
    double :: Num x => x -> x
    double x = x*2
    palindrome :: Eq a => [a] -> Bool 
    palindrome xs = reverse xs == xs 
    twice :: (a -> a) -> a -> a
    twice f x = f (f x)
-}

-- Exercise 3 verify using GHCi with some tests

second :: [a] -> a
second xs = head (tail xs)

swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)

pair :: a -> b -> (a,b)
pair x y = (x,y)

double :: Num a => a -> a
double x = x*2

palindrome :: Eq a => [a] -> Bool
palindrome xs = reverse xs == xs

twice :: (a -> a) -> a -> a
twice f x = f (f x)