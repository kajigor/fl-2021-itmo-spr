module Regexp where

import Prelude hiding (Seq)
-- import Criterion.Config
import Criterion.Main
import Criterion.Types

data Regexp = Empty
            | Epsilon
            | Char Char
            | Seq Regexp Regexp
            | Alt Regexp Regexp
            | Star Regexp
            deriving (Eq, Ord, Show)

match :: Regexp -> String -> Bool
match r s = nullable (foldl (flip derivative) r s)

match' :: Regexp -> String -> Bool
match' r s = nullable (foldl (flip derivative') r s)

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


simplifierAlt :: Char ->  Regexp -> Regexp -> Regexp
simplifierAlt _ Empty _ = Empty
simplifierAlt _ _ Empty = Empty
simplifierAlt c Epsilon r = derivative c r
simplifierAlt c r Epsilon = derivative c r
simplifierAlt c p q | p == q = derivative c p
simplifierAlt c p q = Alt (derivative c p) (derivative c q)


derivative' :: Char -> Regexp -> Regexp
derivative' _ Empty = Empty
derivative' _ Epsilon = Empty
derivative' c (Char r) | c == r = Epsilon
derivative' c (Char r) = Empty
derivative' c (Alt p q) = simplifierAlt c p q
derivative' c (Seq p q) | q == Empty || q == Epsilon = derivative c p
derivative' c (Seq p q) | nullable p = Alt (Seq (derivative c p) q) (derivative c q)
derivative' c (Seq p q) = Seq (derivative c p) q
derivative' c el@(Star (Char x)) = if c == x then el else Empty
derivative' c (Star r) = Seq (derivative c r) (Star r)


regStar :: Regexp
regStar = Seq (Star $ Char 'a') (Char 'a')

regAB :: Regexp
regAB = Star (Alt (Char '0') $ Alt (Char '1') $ Alt (Char '2') (Char '3'))

badAB :: Regexp
badAB = Alt (Star $ Char '0') $ Alt (Star $ Char '1') $ Alt (Star $ Char '2') (Star $ Char '3')

main :: IO ()
main = defaultMain [
        bgroup "Default derivative" [
                     bench ("Reg: " ++ show regStar ++ ". Length 100") $ whnf (match regStar) (replicate 100 'a')
                   , bench ("Reg: " ++ show regStar ++ ". Length 1000")  $ whnf (match regStar) (replicate 1000 'a')
                   , bench ("Reg: " ++ show regStar ++ ". Length 3000")  $ whnf (match regStar) (replicate 3000 'a')
                   , bench ("Reg: " ++ show regAB ++ ". Length 100")  $ whnf (match regAB) $ replicate 25 '1' ++ replicate 25 '2' ++ replicate 25 '3' ++ replicate 25 '0'
                   , bench ("Reg: " ++ show regAB ++ ". Length 1000")  $ whnf (match regAB) $ replicate 250 '1' ++ replicate 250 '2' ++ replicate 250 '3' ++ replicate 250 '0'
                   , bench ("Reg: " ++ show regAB ++ ". Length 3000")  $ whnf (match regAB) $ replicate 750 '1' ++ replicate 750 '2' ++ replicate 750 '3' ++ replicate 750 '0'
                   , bench ("Reg: " ++ show badAB ++ ". Length 100")  $ whnf (match badAB) $ replicate 25 '1' ++ replicate 25 '2' ++ replicate 25 '3' ++ replicate 25 '0'
                   , bench ("Reg: " ++ show badAB ++ ". Length 1000")  $ whnf (match badAB) $ replicate 250 '1' ++ replicate 250 '2' ++ replicate 250 '3' ++ replicate 250 '0'
                   , bench ("Reg: " ++ show badAB ++ ". Length 3000")  $ whnf (match badAB) $ replicate 750 '1' ++ replicate 750 '2' ++ replicate 750 '3' ++ replicate 750 '0'
                   ],
        bgroup "Optimized derivative" [
                     bench ("Reg: " ++ show regStar ++ ". Length 100")   $ whnf (match' regStar) (replicate 100 'a')
                   , bench ("Reg: " ++ show regStar ++ ". Length 1000")  $ whnf (match' regStar) (replicate 1000 'a')
                   , bench ("Reg: " ++ show regStar ++ ". Length 3000")  $ whnf (match' regStar) (replicate 3000 'a')
                   , bench ("Reg: " ++ show regAB ++ ". Length 100")  $ whnf (match' regAB) $ replicate 25 '1' ++ replicate 25 '2' ++ replicate 25 '3' ++ replicate 25 '0'
                   , bench ("Reg: " ++ show regAB ++ ". Length 1000")  $ whnf (match' regAB) $ replicate 250 '1' ++ replicate 250 '2' ++ replicate 250 '3' ++ replicate 250 '0'
                   , bench ("Reg: " ++ show regAB ++ ". Length 3000")  $ whnf (match' regAB) $ replicate 750 '1' ++ replicate 750 '2' ++ replicate 750 '3' ++ replicate 750 '0'
                   , bench ("Reg: " ++ show badAB ++ ". Length 100")  $ whnf (match' badAB) $ replicate 25 '1' ++ replicate 25 '2' ++ replicate 25 '3' ++ replicate 25 '0'
                   , bench ("Reg: " ++ show badAB ++ ". Length 1000")  $ whnf (match' badAB) $ replicate 250 '1' ++ replicate 250 '2' ++ replicate 250 '3' ++ replicate 250 '0'
                   , bench ("Reg: " ++ show badAB ++ ". Length 3000")  $ whnf (match' badAB) $ replicate 750 '1' ++ replicate 750 '2' ++ replicate 750 '3' ++ replicate 750 '0'
                   ]
    ]
