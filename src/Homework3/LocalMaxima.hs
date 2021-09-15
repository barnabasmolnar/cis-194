module Homework3.LocalMaxima where

-- A local maximum of a list is an element of the list which is strictly
-- greater than both the elements immediately before and after it.
-- Write a function

-- localMaxima :: [Integer] -> [Integer]

-- which finds all the local maxima in the input list and returns them in order.
-- For example:

-- localMaxima [2,9,5,6,1] == [9,6]
-- localMaxima [2,3,4,1,5] == [4]
-- localMaxima [1,2,3,4,5] == []

localMaxima :: [Integer] -> [Integer]
localMaxima (a : b : c : xs) | b > a && b > c = b : localMaxima (b : c : xs)
                             | otherwise      = localMaxima (b : c : xs)
localMaxima _ = []

localMaxima' :: [Integer] -> [Integer]
localMaxima' (a : xs@(b : c : _)) | b > a && b > c = b : localMaxima' xs
                                  | otherwise      = localMaxima' xs
localMaxima' _ = []
