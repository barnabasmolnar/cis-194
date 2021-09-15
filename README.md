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

## Homework 2

- [Lecture notes](https://www.seas.upenn.edu/~cis194/spring13/lectures/02-ADTs.html)
- [Homework exercises](https://www.seas.upenn.edu/~cis194/spring13/hw/02-ADTs.pdf)

Notes:

Can be tested with:

```hs
testWhatWentWrong parse whatWentWrong' "./src/Homework2/error.log"
```

## Homework 3

- [Lecture notes](https://www.seas.upenn.edu/~cis194/spring13/lectures/03-rec-poly.html)
- [Homework exercises](https://www.seas.upenn.edu/~cis194/spring13/hw/03-rec-poly.pdf)

Notes:

For the Local Maxima task, I wrote 2 solutions. The 2nd solution, `localMaxima'` takes advantage of the so called _as patterns_ for the sake of conciseness and improved readability. In fact, I've already used this pattern for the `insert` function in Homework 2.

The Histogram exercise can be tested with:

```hs
putStrLn $ histogram [1,4,5,4,6,6,3,4,2,4,9]
```
