module Test.Regexp where

import Test.HUnit (Assertion, assertBool)
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

unit_regexp :: Assertion
unit_regexp = do
  assertBool "a*a" (M.match r1 (replicate 50 'a'))
  assertBool "a*a" (not $ M.match r1 (replicate 50 'a' ++ "b"))

  assertBool "(a|a)*" (M.match r2 (replicate 50 'a'))
  assertBool "(a|a)*" (not $ M.match r2 (replicate 50 'a' ++ "b"))

  assertBool "b|c(a|b)*" (M.match r3 "b")
  assertBool "b|c(a|b)*" (M.match r3 "c")
  assertBool "b|c(a|b)*" (M.match r3 "cabba")
  assertBool "b|c(a|b)*" (not $ M.match r3 "d")
  assertBool "b|c(a|b)*" (not $ M.match r3 "ba")
  assertBool "b|c(a|b)*" (not $ M.match r3 "aaaa")

unit_regexp_fast :: Assertion
unit_regexp_fast = do
  assertBool "a*a" (F.match r1 (replicate 50 'a'))
  assertBool "a*a" (not $ F.match r1 (replicate 50 'a' ++ "b"))

  assertBool "(a|a)*" (F.match r2 (replicate 50 'a'))
  assertBool "(a|a)*" (not $ F.match r2 (replicate 50 'a' ++ "b"))

  assertBool "b|c(a|b)*" (F.match r3 "b")
  assertBool "b|c(a|b)*" (F.match r3 "c")
  assertBool "b|c(a|b)*" (F.match r3 "cabba")
  assertBool "b|c(a|b)*" (not $ F.match r3 "d")
  assertBool "b|c(a|b)*" (not $ F.match r3 "ba")
  assertBool "b|c(a|b)*" (not $ F.match r3 "aaaa")