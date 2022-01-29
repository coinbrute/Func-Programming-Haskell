{-
                                    What is Functional Programming?

    - style of programming in which the basic method of computation is the application of functions to arguments

    - a functional language is one that supports and encourages the functional style of writing code

    - functions should simply take an input and give an output like math with no side effect

    - example 

                summing ints 1-10 in java

                int tot = 0
                for(int 0; i <= 10; i++) {
                    tot = tot + i;
                }

                - the computation method is variable assignment
                - variables 'tot' and 'i'
                - declare variable tot, 
                - then create for loop with variable i and 10
                - then loop ten times reassigning tot until variable i = 10

    - variables have side effecs with reassignment possibilities

                summing ints 1-10 in haskell
                
                sum [1..10]
                
                - the computation method is funciton application
                - functions are sum and [1..10]
                - apply sum function to output of list building function of 1 through 10

-}

{-

    Where did Haskell come from?

    1930s
    - Alonzo Church develops lambda calculus which is a simple but powerful theory of functions.
    - Lamda calculus captures the functional model of computation as opposed to the turing machine which captures the imperitive model
    - Alonzo Church was Alan Turings phd advisor

    1950s
    - John McCarthy develops Lisp, the first functional language, 
    - Lisp came with some influences from the lambda calculus, but retained variable assignments
    - he won turing award i.e. nobel prize for computer science

    1960s
    - Peter Landin develops ISWIM (IF YOU SEE WHAT I MEAN) the first pure function language
    - based strongly on the lambda calculus, with no variable assignments
    - very easy to see as truly functional and correct just by viewing hence the name
    - hard to find examples of

    1970s
    - John Backus develops FP (FUNCTIONAL PROGRAMMING), 
    - FP is a functional language that emphazies higher order functions and mathematical reasoning about programs 
    - also a Turing award winner
    - Also invented Fortran used heavily for math computation

    - Robin Milner and others develop ML (METAL LANGUAGE) 
    - ML was the first "modern" functional language which introduced type inference and polymorphic types 
    - Type inference and Polymorphic types both play major role in Haskell
    - Also Turing award winner

    1970s-1980s
    - David Turner develops a number of lazy functional languages culminating in the miranda system
    - Miranda system is very similar in syntax to Haskell
    
    1987
    - An international committee starts the development of Haskell
    - Haskell is a standard lazy functional language
    
    1990s
    - Phil Wadler and others develop type classes and monads
    - These are two of the main innovations of Haskell

    2003
    - The committee publishes the Haskell Report defining a stable version of the language 
    - An updated vesion was published in 2010

    2010-Current
    - A standard distribution has been delivered
    - There is large library support
    - There are new language features coming out often
    - dev tools out now with support on vsCode and other large release IDEs
    - use in industry that wasn't there before
    - influence on other languages with its format and typing 

-}

{-

    A taste of Haskell

    f [] = []
    f (x:xs) = f ys ++ [x] ++ f zs
        where
            ys = [a | a <- xs, a <= x]
            zs = [b | b <- xs, b > x]

    - The [] are lists i.e [1,2,3,4,5]
    - an empty [] is an empty list
    - list with one thing or a SINGLETON is [1] or in code [x]
    - ++ takes one list and appends another list to it i.e. [1,2,3] ++ [4,5,6] = [1,2,3,4,5,6]
    - : takes one value and appends list to it i.e. 1:[2,3,4] = [1,2,3,4] 
    - : can also break apart list with patterns
    - (x:xs) is a pattern where a list is broken apart with x being first value and xs being everything after
    - [newListValue | newListValue <- fromList, newListValue == someValue] list comprehension method to build lists
    - use where to create local functions within

    QuickSort
    f [3,1,4,2]
    Run through:
    x = 3
    xs = [1,4,2]
    f [1,2] ++ [3] ++ f [4]
    f[] ++ [1] ++ f [2] ++ [3]  ++ [4]
    [] ++ [1] ++ [2] ++ [3] ++[4]
    [1,2,3,4]

    As a rule of thumb a function definition is a read as follows using quicksort as an example

                            qsort :: Ord a => [a] -> [a]

    - left hand side of double colon is function name
    - if there is a '=>' the value to the left is/are the parameter data constraint/s
        - in this case qsort requires that the parameter of type [a] also be an Ord Class
        - The Ord class is used for totally ordered datatypes.
    - To the right of the constraint is the parameters 
    - The last item is the return type
                            qsort :: Ord a => [a] -> [a]
    - qsort is a function that takes one list that is of type Ord and returns a list of type Ord 
    - both lists must be the same type
    - whatever is passed in must be of Ord Data type
-}

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort ys ++ [x] ++ qsort zs
    where
        ys = [a | a <- xs, a <= x]
        zs = [b | b <- xs, b > x]


