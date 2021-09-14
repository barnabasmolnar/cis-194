{-# OPTIONS_GHC -Wall #-}
module Homework2.ParseLogFile where

import           Homework2.Log                  ( LogMessage(..)
                                                , MessageTree(..)
                                                , MessageType(..)
                                                )
-- ==========
-- Exercise 1
-- ==========
-- The first step is figuring out how to parse an individual message.
-- Define a function

-- parseMessage :: String -> LogMessage

-- which parses an individual line from the log file. For example,
-- parseMessage "E 2 562 help help" == LogMessage (Error 2) 562 "help help"
-- parseMessage "I 29 la la la" == LogMessage Info 29 "la la la"
-- parseMessage "This is not in the right format" == Unknown "This is not in the right format"

parseMessage :: String -> LogMessage
parseMessage s = case words s of
    ("E" : ec : ts : xs) -> LogMessage (Error $ read ec) (read ts) (unwords xs)
    ("I"      : ts : xs) -> LogMessage Info (read ts) (unwords xs)
    ("W"      : ts : xs) -> LogMessage Warning (read ts) (unwords xs)
    _                    -> Unknown s

-- Once we can parse one log message, we can parse a whole log file.
-- Define a function

-- parse :: String -> [LogMessage]

-- which parses an entire log file at once and returns its contents as a
-- list of LogMessages.

parse :: String -> [LogMessage]
parse = map parseMessage . lines

-- ==========
-- Exercise 2
-- ==========
-- Define a function

-- insert :: LogMessage -> MessageTree -> MessageTree

-- which inserts a new LogMessage into an existing MessageTree,
-- producing a new MessageTree. insert may assume that it is given a
-- sorted MessageTree, and must produce a new sorted MessageTree
-- containing the new LogMessage in addition to the contents of the
-- original MessageTree.
-- However, note that if insert is given a LogMessage which is Unknown,
-- it should return the MessageTree unchanged.

insert :: LogMessage -> MessageTree -> MessageTree
insert m@LogMessage{} Leaf = Node Leaf m Leaf
insert m@(LogMessage _ ts _) (Node l m'@(LogMessage _ ts' _) r)
    | ts < ts'  = Node (insert m l) m' r
    | otherwise = Node l m' (insert m r)
insert _ t = t

-- ==========
-- Exercise 3
-- ==========
-- Once we can insert a single LogMessage into a MessageTree, we can build
--  a complete MessageTree from a list of messages.
-- Specifically, define a function

-- build :: [LogMessage] -> MessageTree

-- which builds up a MessageTree containing the messages in the list,
-- by successively inserting the messages into a MessageTree (beginning
-- with a Leaf).

build :: [LogMessage] -> MessageTree
build = foldr insert Leaf

-- ==========
-- Exercise 4
-- ==========
-- Finally, define the function

-- inOrder :: MessageTree -> [LogMessage]

-- which takes a sorted MessageTree and produces a list of all the
-- LogMessages it contains, sorted by timestamp from smallest to biggest.

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf         = []
inOrder (Node l m r) = inOrder l ++ [m] ++ inOrder r

-- ==========
-- Exercise 5
-- ==========
-- Now that we can sort the log messages, the only thing left to do is
-- extract the relevant information. We have decided that “relevant” means
-- “errors with a severity of at least 50”.
-- Write a function

-- whatWentWrong :: [LogMessage] -> [String]

-- which takes an unsorted list of LogMessages, and returns a list of the
-- messages corresponding to any errors with a severity of 50 or greater,
-- sorted by timestamp. 

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong = map (\(LogMessage _ _ m) -> m) . filter f . inOrder . build
  where
    f (LogMessage (Error ec) _ _) = ec >= 50
    f _                           = False

-- a slightly more compact and perhaps more efficient version with only
-- one pass over the list
whatWentWrong' :: [LogMessage] -> [String]
whatWentWrong' = concatMap f . inOrder . build
  where
    f (LogMessage (Error ec) _ m) | ec >= 50 = [m]
    f _ = []
