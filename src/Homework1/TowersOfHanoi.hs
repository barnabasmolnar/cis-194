module Homework1.TowersOfHanoi where

-- ==========
-- Exercise 5
-- ==========  
-- The Towers of Hanoi is a classic puzzle with a solution that can be described
-- recursively. Disks of different sizes are stacked on three pegs;
-- the goal is to get from a starting configuration with
-- all disks stacked on the first peg to an ending configuration with all
-- disks stacked on the last peg.


-- The only rules are:
-- - you may only move one disk at a time, and
-- - a larger disk may never be stacked on top of a smaller one

-- Given the number of discs and names for the three pegs, hanoi should
-- return a list of moves to be performed to move the stack of discs from
-- the first peg to the second.

-- Example: hanoi 2 "a" "b" "c" == [("a","c"), ("a","b"), ("c","b")]

type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 0 _ _ _ = []
hanoi n a b c = hanoi (n - 1) a c b ++ [(a, b)] ++ hanoi (n - 1) c b a