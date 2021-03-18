module Main where

import Criterion.Main
import Regexp

a :: Regexp
a = Char 'a'

b :: Regexp
b = Char 'b'

c :: Regexp
c = Char 'c'

-- a*a
r1 :: Regexp
r1 = Seq (Star a) a

-- (a|a)*
r2 :: Regexp
r2 = Star (Alt a a)

-- b | (c (a|b)*)
r3 :: Regexp
r3 = Alt b (Seq c (Star (Alt a b)))

main :: IO ()
main = defaultMain [
  bgroup "Match regular" [
      bench "a*a, 5000 times" $ whnf (match r1) (replicate 5000 'a'),
      bench "b|c(a|b)*, 5000 times" $ whnf (match r3) (concat $ replicate 5000 "badabac")
    ],
  bgroup "Match optimized" [
        bench "a*a, 5000 times" $ whnf (optMatch r1) (replicate 5000 'a'),
        bench "b|c(a|b)*, 5000 times" $ whnf (optMatch r3) (concat $ replicate 5000 "badabac")
    ]
  ]