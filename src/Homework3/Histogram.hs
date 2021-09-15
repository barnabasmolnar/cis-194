module Homework3.Histogram where

import           Control.Arrow                  ( Arrow((&&&)) )
import           Data.List                      ( group
                                                , sort
                                                , transpose
                                                )
import           Data.Maybe                     ( fromMaybe )

-- For this task, write a function

-- histogram :: [Integer] -> String

-- which takes as input a list of Integers between 0 and 9 (inclusive),
-- and outputs a vertical histogram showing how many of each number
-- were in the input list. You may assume that the input list does not
-- contain any numbers less than zero or greater than 9.

-- countPerNumber takes a list of Ints and returns a count of each numbers
-- occurrence in the list
-- eg countPerNumber [1,4,5,4,6,6,3,4,2,4,9] == [(1,1),(2,1),(3,1),(4,4),(5,1),(6,2),(9,1)]
countPerNumber :: [Int] -> [(Int, Int)]
countPerNumber = map (\g -> (head g, length g)) . group . sort

-- a slightly more concise version of countPerNumber
countPerNumber' :: [Int] -> [(Int, Int)]
countPerNumber' = map (head &&& length) . group . sort

-- given a list of Ints, countPerNumberInRange returns a list of counts for the
-- range of 0..9
-- eg. countPerNumberInRange [1,4,5,4,6,6,3,4,2,4,9] == [0,1,1,1,4,1,2,0,0,1]
countPerNumberInRange :: [Int] -> [Int]
countPerNumberInRange ns = map f [0 .. 9]
  where
    counts = countPerNumber' ns
    f x = fromMaybe 0 $ lookup x counts

-- stars takes a list of Ints and returns a list of * Strings representing
-- each number's count in the list
-- eg. stars [1,4,5,4,6,6,3,4,2,4,9] == ["","*","*","*","****","*","**","","","*"]
stars :: [Int] -> [String]
stars = map f . countPerNumberInRange where f c = replicate c '*'

padStart :: Int -> String -> String
padStart n s | n > len   = replicate (n - len) ' ' ++ s
             | otherwise = s
    where len = length s

-- okay, so this a bit involved...
-- our histrogram needs to be rendered vertically
-- so something like ["","*","*","*","****","*","**","","","*"] separated by
-- newlines won't quite do just yet
-- if we think of the above in terms of rows and columns
-- and take the transpose library function, which "transposes the rows and
-- columns of its arguments", we can effectively "rotate" the list
-- the only one issue now is that for our use case, transpose will only work
-- if all items in the list are of the same length
-- map (padStart largestStar) stars' produces something like this:
-- ["    ","   *","   *","   *","****","   *","  **","    ","    ","   *"]
-- satisfying the above condition
histogram :: [Int] -> String
histogram xs = graph ++ base
  where
    base        = "==========\n0123456789\n"
    stars'      = stars xs
    largestStar = length $ maximum stars'
    graph       = unlines $ transpose $ map (padStart largestStar) stars'


-- an alternative version of stars
-- this one expects a list of counts and spits out the list of padded * Strings
stars' :: [Int] -> [String]
stars' ns = map f ns
  where
    len = maximum ns
    f c = replicate (len - c) ' ' ++ replicate c '*'

-- we can now write histogram a bit more concisely with stars'
-- in all honesty, this version was recommended to me by a more experienced
-- Haskeller friend of mine :)
-- but I quite like it, so here it is
histogram' :: [Int] -> String
histogram' xs = graph ++ base
  where
    base  = "==========\n0123456789\n"
    graph = unlines $ transpose $ stars' $ countPerNumberInRange xs
