module Regexp where

import Prelude hiding (Seq)

data Regexp = Empty
            | Epsilon
            | Char Char
            | Seq Regexp Regexp
            | Alt Regexp Regexp
            | Star Regexp
            deriving (Eq, Ord)

match :: Regexp -> String -> Bool
match r s = nullable (foldl (flip derivative) r s)

nullable :: Regexp -> Bool
nullable Empty     = False
nullable Epsilon   = True
nullable (Char _)  = False
nullable (Alt p q) = nullable p || nullable q
nullable (Seq p q) = nullable p && nullable q
nullable (Star _)  = True

derivative :: Char -> Regexp -> Regexp
derivative _ Empty = Empty
derivative _ Epsilon = Empty
derivative c (Char r) | c == r = Epsilon
derivative c (Char r) = Empty
derivative c (Alt p q) = Alt (derivative c p) (derivative c q)
derivative c (Seq p q) | nullable p = Alt (Seq (derivative c p) q) (derivative c q)
derivative c (Seq p q) = Seq (derivative c p) q
derivative c (Star r) = Seq (derivative c r) (Star r)

optDeriv :: Char -> Regexp -> Regexp
optDeriv _ Empty = Empty
optDeriv _ Epsilon = Empty
optDeriv c (Char r) | c == r = Epsilon
optDeriv c (Char r) = Empty
optDeriv c (Alt p Empty) = derivative c p
optDeriv c (Alt Empty q) = derivative c q
optDeriv c (Alt p q) | p == q = derivative c p
optDeriv c (Alt p q) = Alt (derivative c p) (derivative c q)
optDeriv c (Seq p q) | nullable p = Alt (Seq (optDeriv c p) q) (optDeriv c q)
optDeriv c (Seq p q) = if p == Empty || q == Empty then Empty else Seq (optDeriv c p) q
optDeriv c (Star r) = Seq (optDeriv c r) (Star r)


optMatch :: Regexp -> String -> Bool
optMatch r s = nullable (foldl (flip optDeriv) r s)