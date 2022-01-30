{-
                                    Introduction
    - many funcitons can naturally be defined in terms of other functions 
        fac :: Int -> Int
        fac n = product [1..n]
        - the factorial is the product of 1 and n
    - fac maps any integer n to the product of the integers between 1 and n
    - expressions ae evaluated by a stepwise process of applying funcitons to their args 
        - For example fac above equates to:
            > fac 4
            > product [1..4]
            > product [1,2,3,4]
            > 1*2*3*4
            > 24
-}
fac :: Int -> Int
fac n = product [1..n]
{-
                                Recursive Function
    - functions can also be defined in terms of themselves
    - fuctions that do this are called recursive
        - For example 
        fac 0 = 1
        fac n = n * fac (n-1)
    - fac maps 0 to 1 and any other integer to the product of itself and the factorial of its predecessor
    - when defining recursive funcs on non negative/natural numbers typically have a base case for 0 and case for n 
        - For example:
            > fac 3
            > 3 * fac 2
            > 3 * (2 * fac 1)
            > 3 * (2 * (1 fac 0))
            > 3 * (2 * (1 * 1))
            > 3 * (2 * (1))
            > 3 * 2
            > 6
    - fac 0 =1 is appropirate because 1 is the identity for mulitplication
        - 1*x = x = x*1
    - the recursive definition diverges on integers < 0 because the base case is never reached
        > fac (-1)
        *** Exception: Stack overflow
-}
fac' :: Int -> Int
fac' 0 = 1
fac' n = n * fac (n-1)

{-
                                            Why is Recursion Useful
    - some funcitons such as factorial are simpler to define in terms of other functions
    - many funcitons can naturally be defined in terms of themselves
    - properties of functions defined using recursion can be proved using the simple but powerful mathematical technique of induction/proofs
-}

{-
                                            Recursion on Lists
    - recursion is not resticted to numbers 
    - can also be used to define funcitons on lists
        product :: Num a => [a] -> a
        product []     = 1
        product (n:ns) = n * product ns
    - product maps the empty list to 1 and any nonepmy list to its head multiplied by the product of its tail
        - For Example: 
        > product [2,3,4]
        > 2 * product [3,4]
        > 2 * (3 * product [4])
        > 2 * (3 * (4 * product []))
        > 2 * (3 * (4 * 1))
        > 24

    - using the same pattern of recursion as in product we can define the length function on lists 
        length :: [a] -> Int
        length [] = 0
        length (_:xs) = 1 + length xs
    - length maps the empty list to 0 and any non empty list to the successor of the length of its tail
        - For Example:
        > length [1,2,3]
        > 1 + length [2,3]
        > 1 + (1 + length [3])
        > 1 + (1 + (1 + length []))
        > 1 + (1 + (1 + 0))
        > 3

    - using a similar pattern of recursion the reverse funciton can be defined
        reverse :: [a] -> [a]
        reverse [] = []
        reverse (x:xs) = reverse xs ++ [x]
    - reverse maps the empty list to the empty list and any non empty list to the reverse of its tail appended to its head
        - For Example:
        > reverse [1,2,3]
        > reverse [2,3] ++ [1]
        > (reverse [3] ++ [2]) ++ [1]
        > ((reverse [] ++ [3]) ++ [2]) ++ [1]
        > (([] ++ [3]) ++ [2]) ++ [1]
        > [3,2,1]
-}

product' :: Num a => [a] -> a
product' []     = 1
product' (n:ns) = n * product' ns

length' :: [a] -> Int
length' []     = 0
length' (_:xs) = 1 + length' xs

reverse' :: [a] -> [a]
reverse' []     = []
reverse' (x:xs) = reverse' xs ++ [x]

{-
                                                Mulitple Arguments
    - functions with more than one arguments can also be defined using recursion
    - zipping the elements of two lists
        zip :: [a] -> [b] -> [(a,b)]
        zip [] _ = []
        zip _ [] = []
        zip (x:xs) (y:ys) = (x,y) : zip xs ys

        - For Example:
        > zip [1,2] ['a','b']
        > (1,'a') : zip [2] ['b']
        > (1,'a') : ((2,'b') : zip [] [])
        > [(1,'a'),(2,'b')]

    - Removing the first n elements from a list
        drop :: Int -> [a] -> [a]
        drop 0 xs = xs 
        drop _ [] = []
        drop n (_:xs) = drop (n-1) xs

        - For Example: 
        > drop 2 [1,2,3]
        > drop 1 [2,3]
        > drop 0 [3]
        > [3]

    - appending two lists
        (++) :: [a] -> [a] -> [a]
        [] ++ ys = ys
        (x:xs) ++ ys = x : (xs ++ ys)

        - For Example: 
        > [1,2] ++ [3,4]
        > 1 : ([2] ++ [3,4])
        > 1 : (2 : ([] ++ [3,4]))
        > 1 : (2 : ([3,4]))
        > [1,2,3,4]
-}
zip' :: [a] -> [b] -> [(a,b)]
zip' []     _      = []
zip' _      []     = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys

drop' :: Int -> [a] -> [a]
drop' 0 xs     = xs 
drop' _ []     = []
drop' n (_:xs) = drop' (n-1) xs

(+++) :: [a] -> [a] -> [a]
[] +++ ys = ys
(x:xs) +++ ys = x : (xs +++ ys)

{-
                                        Quicksort
    - the quicksort algorithm forsorting a list of values can be specified by the following tow rules
        - the empty list is already sorted
        - non empty lists can be sorted by 
            - sorting the tail values <= the head
            - sorting the tails values > the head
            - then appending the resulting lists on either side of the head value
    - using recursion this specification can be translate ddirectly into an implementaion
        qsort :: Ord a => [a] -> [a]
        qsort []     = []
        qsort (x:xs) =
            qsort smaller ++ [x] ++ qsort larger
            where 
                smaller = [a | a <- xs, a <= x]
                larger  = [b | b <- xs, b > x]
    - this is probably the simplest implementation of quicksort in any programming language
    - base case is empty list being already sorted
    - first recursive call is sorting smaller list
    - second is sorting the larger list
    - larger list is all value in tail of list larger than viewed value
    - smaller list is all values in tail of list larger than viewed value
    - polymorphic and recursive

                                - For Example:
                                > q [3,2,4,1,5]
                                x = 3
        > q [2,1] ++                [3] ++              q [4,5]
          x = 2                                          x = 4
    > q [1] ++ [2] ++ q []                          q [] ++ [4] ++ q [5]
         [1]            []                          []              [5]

       >  [1] : [2] : [] : [3] : [] : [4] : [5]
       > [1,2,3,4,5]
-}  

qsort :: Ord a => [a] -> [a]
qsort []     = []
qsort (x:xs) =
    qsort smaller ++ [x] ++ qsort larger
    where 
        smaller = [a | a <- xs, a <= x]
        larger  = [b | b <- xs, b > x]

{-
    Exercise 1:
    - Without looking at prelude define the followign library functions using recursion:
-}
-- Decide if all logical values in a list are true:
and' :: [Bool] -> Bool
and' [] = True
and' (False:_) = False
and' (_:xs) = and' xs

{-
    Walkthrough
    > and' [True,True,True]
    > and' [True,True]
    > and' [True]
    > and' []
    > True
-}

-- Concatenate a list of lists:
concat' :: [[a]] -> [a]
concat' [] = []
concat' (x:xs) = x ++ concat' xs

{-
    Walkthrough
    > concat' [[1,2],[3]]
    > [1,2] ++ concat' [[3]]
    > [1,2] ++ [3] ++ concat []
    > [1,2] ++ [3] ++ []
    > [1,2,3]
-}

-- Produce a list with n identical elements:
replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' n x = x : replicate' (n-1) x

{-
    Walkthrough
    > replicate' 3 1
    > 1 : (replicate' 2 1)
    > 1 : (1 : replicate 1 1)
    > 1 : (1 : (1 : (replicate 0 1)))
    > 1 : (1 : (1 : ([])))
    > 1:1:1:[]
    > [1,1,1]
-}

-- Select the nth element of a list:
(!!!) :: [a] -> Int -> a
(x:_) !!! 0 = x
(_:xs) !!! n = xs !!! (n-1)

{-
    Walkthrough
    > [1,2,3] !!! 2
    > [2,3] !!! 1
    > [3] !!! 0
    > 3
-}

-- Decide if a value is an element of a list:
elem' :: Eq a => a -> [a] -> Bool
elem' v []     = False 
elem' v (x:xs) = if v == x then True else elem' v xs

{-
    Walkthrough
    > elem' 2 [1,2,3]
    > if 1 == 2 
    else 
    > elem' 2 [2,3]
    > False || (2 == 2 = True || elem' 2 [3])
    > False || True
    > True
-}

-- {-
--     Exercise 2:
--     - define a recursive function
--         merge :: Ord a => [a] -> [a] -> [a]
--     - this function should merge two sorted lists of values to give a single sorted list 
--         - For Example: 
--         > merge [2,5,6] [1,3,4]
--         > [1,2,3,4,5,6]
-- -}
merge' :: Ord a => [a] -> [a] -> [a]
merge' xs     []     = xs
merge' []     ys     = ys
merge' (x:xs) (y:ys) = if x < y then x : merge' xs (y:ys) else y : merge' (x:xs) ys

{-
    Walkthrough
    > merge [2,5,6] [1,3,4]
    > if 2 < 1 
        no go to else
    > 1 : (merge' [2,5,6] [3,4])
    > if 2 < 3
        yes go to then
    > 1 : (2 : (merge' [5,6] [3,4]))
    > if 5 < 3
        no go to else
    > 1 : (2 : (3 : (merge' [5,6] [4])))
    > if 5 < 4
        no go to else
    > 1 : (2 : (3 : (4: (merge' [5,6] []))))
    > 1:2:3:4:[5,6]
    >[1,2,3,4,5,6]
-}

-- {-
--     Exercise 3:
--     Define a recursive function
--         msort :: Ord a => [a] -> [a]
--     - this function should be a merge sort which can be specified by the following two rules
--         - lists of length <= 1 are already sorted
--         - other lists can be sorted by sorting the two halves and merging the resulting lists
-- -}
msort' :: Ord a => [a] -> [a]
msort' []     = [] -- return empty lists
msort' [x] = [x] -- return lists of size one
msort' (x:xs) = merge' (msort' (take (length xs `div` 2) xs)) (msort' (drop (length xs `div` 2) xs))
