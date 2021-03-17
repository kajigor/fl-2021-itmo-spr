module Main where

import Criterion.Main ( defaultMain, whnf, bench, bgroup )
import Regexp (Regexp (..))
import qualified Match as M (match)
import qualified MatchFast as F (match)

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
  bgroup "Plain" [ 
      bench "a*a" $ whnf (M.match r1) (replicate 1000 'a'),
      bench "a*a" $ whnf (M.match r1) (replicate 1000 'a' ++ "b"),

      bench "(a|a)*" $ whnf (M.match r2) (replicate 1000 'a'),
      bench "(a|a)*" $ whnf (M.match r2) (replicate 1000 'a' ++ "b"),

      bench "b|c(a|b)*" $ whnf (M.match r3) (replicate 1000 'b'),
      bench "b|c(a|b)*" $ whnf (M.match r3) (replicate 1000 'c'),
      bench "b|c(a|b)*" $ whnf (M.match r3) (concat $ replicate 1000 "cabba")
    ],
  bgroup "Optimized" [ 
      bench "a*a" $ whnf (F.match r1) (replicate 1000 'a'),
      bench "a*a" $ whnf (F.match r1) (replicate 1000 'a' ++ "b"),

      bench "(a|a)*" $ whnf (F.match r2) (replicate 1000 'a'),
      bench "(a|a)*" $ whnf (F.match r2) (replicate 1000 'a' ++ "b"),

      bench "b|c(a|b)*" $ whnf (F.match r3) (replicate 1000 'b'),
      bench "b|c(a|b)*" $ whnf (F.match r3) (replicate 1000 'c'),
      bench "b|c(a|b)*" $ whnf (F.match r3) (concat $ replicate 1000 "cabba")
    ]
  ]
