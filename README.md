# cis194

This repo is an attempt at solving some of the homework exercises from https://www.seas.upenn.edu/~cis194/spring13/. This resource was first recommended to me by a friend, but I have also read several positive threads about it on the /r/haskell subreddit, as well as [this recommendation](https://bitemyapp.com/blog/functional-education/).

This project has been initialised by [stack](https://docs.haskellstack.org/en/stable/README/).

## Homework 1

- [Lecture notes](https://www.seas.upenn.edu/~cis194/spring13/lectures/01-intro.html)
- [Homework exercises](https://www.seas.upenn.edu/~cis194/spring13/hw/01-intro.pdf)

Notes:

Despite the instructions in **Exercise 4** in that

> This will use all functions defined in the previous exercises.

I ended up not using `toDigitsRev` for the final `validate` function, as the `doubleEveryOther` function already does right-to-left doubling of every other digit.
