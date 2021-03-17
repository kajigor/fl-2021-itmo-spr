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

matchAlt :: Regexp -> String -> Bool
matchAlt r s = nullable (foldl (flip derivativeAlt) r s)

matchSeq :: Regexp -> String -> Bool
matchSeq r s = nullable (foldl (flip derivativeSeq) r s)

matchEvry :: Regexp -> String -> Bool
matchEvry r s = nullable (foldl (flip derivativeEvry) r s)

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

altA :: Regexp -> Regexp -> Regexp
altA Empty q = q
altA p Empty = p
altA Epsilon (Star b) = Star b
altA (Star a) Epsilon = Star a
altA p q | p == q = p
         | otherwise = Alt p q

seqS :: Regexp -> Regexp -> Regexp
seqS Epsilon q = q
seqS p Epsilon = p
seqS Empty q = Empty
seqS p Empty = Empty
seqS p q = Seq p q

altE :: Regexp -> Regexp -> Regexp
altE Empty q = q
altE p Empty = p
altE Epsilon (Star b) = Star b
altE (Star a) Epsilon = Star a
altE p q | p == q = p
         | otherwise = Alt p q

seqE :: Regexp -> Regexp -> Regexp
seqE Epsilon q = q
seqE p Epsilon = p
seqE Empty q = Empty
seqE p Empty = Empty
seqE p q = Seq p q

derivativeAlt :: Char -> Regexp -> Regexp
derivativeAlt _ Empty = Empty
derivativeAlt _ Epsilon = Empty
derivativeAlt c (Char r) | c == r = Epsilon
                         | otherwise = Empty
derivativeAlt c (Alt p q) = altA (derivativeAlt c p) (derivativeAlt c q)
derivativeAlt c (Seq p q) | nullable p = altA (Seq (derivativeAlt c p) q) (derivativeAlt c q)
                          | otherwise = Seq (derivativeAlt c p) q
derivativeAlt c (Star r) = Seq (derivativeAlt c r) (Star r)

derivativeSeq :: Char -> Regexp -> Regexp
derivativeSeq _ Empty = Empty
derivativeSeq _ Epsilon = Empty
derivativeSeq c (Char r) | c == r = Epsilon
                         | otherwise = Empty
derivativeSeq c (Alt p q) = Alt (derivativeSeq c p) (derivativeSeq c q)
derivativeSeq c (Seq p q) | nullable p = Alt (seqS (derivativeSeq c p) q) (derivativeSeq c q)
                          | otherwise = seqS (derivativeSeq c p) q
derivativeSeq c (Star r) = seqS (derivativeSeq c r) (Star r)

derivativeEvry :: Char -> Regexp -> Regexp
derivativeEvry _ Empty = Empty
derivativeEvry _ Epsilon = Empty
derivativeEvry c (Char r) | c == r = Epsilon
                         | otherwise = Empty
derivativeEvry c (Alt p q) = altE (derivativeEvry c p) (derivativeEvry c q)
derivativeEvry c (Seq p q) | nullable p = altE (seqE (derivativeEvry c p) q) (derivativeEvry c q)
                           | otherwise = seqE (derivativeEvry c p) q
derivativeEvry c (Star r) = seqE (derivativeEvry c r) (Star r)
