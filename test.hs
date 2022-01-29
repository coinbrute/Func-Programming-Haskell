{- 
    My first script for first-steps lecture 2
-}

-- x is doubled. pretty straight forward
double x = x + x 
-- x is applied to the double function and the output is applied to the double function again
quadruple x = double (double x)
-- get factorial of 1 to n
factorial n = product [1..n]
-- get the average of ns
    -- div is infix called so it uses `` backquotes
    -- x `f` y is the same as f x y
average ns = sum ns `div` length ns
