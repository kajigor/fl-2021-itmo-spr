import Regexp
import Criterion.Main
import Data.List

aStr = take 3000 (repeat 'a')
bStr = take 3000 (repeat 'b')
cStr = take 3000 (repeat 'c')
abStr = intersperse 'b' (take 1500 aStr)
revLetters = take 3000 (cycle "qwe")
letRegexp = Star (Alt (Char 'p') (Alt (Char 'o') (Alt (Char 'i') (Alt (Char 'u') (Alt (Char 'y') (Alt (Char 't') (Alt (Char 'r') (Alt (Char 'e') (Alt (Char 'w') (Char 'q'))))))))))
seqReg = Star (Alt (Seq (Char 'a') (Char 'b')) (Seq (Char 'a') (Char 'q')))
seqStr = take 3000 (cycle "abaq")

main :: IO ()
main = defaultMain [ bgroup "no upgrades" [ bench "aaa.... string (3000 chars) with a* regexp" $ whnf (match $ Star (Char 'a')) aStr
                                          , bench "aaa.... string (3000 chars) with (a|b)* regexp" $ whnf (match $ Star (Alt (Char 'a') (Char 'b'))) aStr
                                          , bench "bbb.... string (3000 chars) with (a|b)* regexp" $ whnf (match $ Star (Alt (Char 'a') (Char 'b'))) bStr
                                          , bench "ccc.... string (3000 chars) with (a|b)* regexp" $ whnf (match $ Star (Alt (Char 'a') (Char 'b'))) cStr
                                          , bench "abab.... string (2999 chars) with (a|b)* regexp" $ whnf (match $ Star (Alt (Char 'a') (Char 'b'))) abStr
                                          , bench "qweqweqwe... string (3000 chars )with (p|o|i|u|...|w|q)* regexp" $ whnf (match letRegexp) revLetters
                                          , bench "abaqabaqabaq... string (3000 chars) with (ab|aq)* regexp" $ whnf (match seqReg) seqStr
                                          ]
                    , bgroup "alt upgrades" [ bench "aaa.... string (3000 chars) with a* regexp" $ whnf (matchAlt $ Star (Char 'a')) aStr
                                            , bench "aaa.... string (3000 chars) with (a|b)* regexp" $ whnf (matchAlt $ Star (Alt (Char 'a') (Char 'b'))) aStr
                                            , bench "bbb.... string (3000 chars) with (a|b)* regexp" $ whnf (matchAlt $ Star (Alt (Char 'a') (Char 'b'))) bStr
                                            , bench "ccc.... string (3000 chars) with (a|b)* regexp" $ whnf (matchAlt $ Star (Alt (Char 'a') (Char 'b'))) cStr
                                            , bench "abab.... string (2999 chars) with (a|b)* regexp" $ whnf (matchAlt $ Star (Alt (Char 'a') (Char 'b'))) abStr
                                            , bench "qweqweqwe... string (3000 chars )with (p|o|i|u|...|w|q)* regexp" $ whnf (matchAlt letRegexp) revLetters
                                            , bench "abaqabaqabaq... string (3000 chars) with (ab|aq)* regexp" $ whnf (matchAlt seqReg) seqStr
                                            ]
                    , bgroup "seq upgrades" [ bench "aaa.... string (3000 chars) with a* regexp" $ whnf (matchSeq $ Star (Char 'a')) aStr
                                            , bench "aaa.... string (3000 chars) with (a|b)* regexp" $ whnf (matchSeq $ Star (Alt (Char 'a') (Char 'b'))) aStr
                                            , bench "bbb.... string (3000 chars) with (a|b)* regexp" $ whnf (matchSeq $ Star (Alt (Char 'a') (Char 'b'))) bStr
                                            , bench "ccc.... string (3000 chars) with (a|b)* regexp" $ whnf (matchSeq $ Star (Alt (Char 'a') (Char 'b'))) cStr
                                            , bench "abab.... string (2999 chars) with (a|b)* regexp" $ whnf (matchSeq $ Star (Alt (Char 'a') (Char 'b'))) abStr
                                            , bench "qweqweqwe... string (3000 chars )with (p|o|i|u|...|w|q)* regexp" $ whnf (matchSeq letRegexp) revLetters
                                            , bench "abaqabaqabaq... string (3000 chars) with (ab|aq)* regexp" $ whnf (matchSeq seqReg) seqStr
                                            ]
                    , bgroup "evry upgrade" [ bench "aaa.... string (3000 chars) with a* regexp" $ whnf (matchEvry $ Star (Char 'a')) aStr
                                            , bench "aaa.... string (3000 chars) with (a|b)* regexp" $ whnf (matchEvry $ Star (Alt (Char 'a') (Char 'b'))) aStr
                                            , bench "bbb.... string (3000 chars) with (a|b)* regexp" $ whnf (matchEvry $ Star (Alt (Char 'a') (Char 'b'))) bStr
                                            , bench "ccc.... string (3000 chars) with (a|b)* regexp" $ whnf (matchEvry $ Star (Alt (Char 'a') (Char 'b'))) cStr
                                            , bench "abab.... string (2999 chars) with (a|b)* regexp" $ whnf (matchEvry $ Star (Alt (Char 'a') (Char 'b'))) abStr
                                            , bench "qweqweqwe... string (3000 chars )with (p|o|i|u|...|w|q)* regexp" $ whnf (matchEvry letRegexp) revLetters
                                            , bench "abaqabaqabaq... string (3000 chars) with (ab|aq)* regexp" $ whnf (matchEvry seqReg) seqStr
                                            ]
                    ]
