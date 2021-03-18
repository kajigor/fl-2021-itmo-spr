module Main where

import Regexp (Regexp (..), match, match')
import Test.HUnit (Assertion, assertBool)
import Criterion.Main ( defaultMain, whnf, bench, bgroup )

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

main = defaultMain [
  bgroup "no optimization" 
  [ bench "a*a" $ whnf (match r1) (replicate 3000 'a')

  , bench "(a|a)*" $ whnf (match r2) (replicate 3000 'a')

  , bench "b|c(a|b)*" $ whnf (match r3) (replicate 3000 'b')
  , bench "b|c(a|b)*" $ whnf (match r3) (replicate 3000 'c')
  , bench "b|c(a|b)*" $ whnf (match r3) (concat (replicate 3000 "cabba"))
  ],
  bgroup "smart constructors"
  [ bench "a*a" $ whnf (match' r1) (replicate 3000 'a')

  , bench "(a|a)*" $ whnf (match' r2) (replicate 3000 'a')

  , bench "b|c(a|b)*" $ whnf (match' r3) (replicate 3000 'b')
  , bench "b|c(a|b)*" $ whnf (match' r3) (replicate 3000 'c')
  , bench "b|c(a|b)*" $ whnf (match' r3) (concat (replicate 3000 "cabba"))
  ]
  ]