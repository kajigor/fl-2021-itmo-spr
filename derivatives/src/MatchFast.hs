module MatchFast where

import Prelude hiding (Seq, seq)
import Regexp (Regexp (..))

alt :: Regexp -> Regexp -> Regexp
alt Empty p = p
alt p Empty = p
alt p p' | p == p' = p
alt p q = Alt p q

seq :: Regexp -> Regexp -> Regexp 
seq p Empty = Empty
seq Empty p = Empty
seq p Epsilon = p
seq Epsilon p = p
seq p q = Seq p q

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
derivative c (Alt p q) = alt (derivative c p) (derivative c q)
derivative c (Seq p q) | nullable p = alt (seq (derivative c p) q) (derivative c q)
derivative c (Seq p q) = seq (derivative c p) q
derivative c (Star r) = seq (derivative c r) (Star r)