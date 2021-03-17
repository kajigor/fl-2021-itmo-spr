import Test.Tasty
import Test.Tasty.HUnit

import Data.Either (isLeft)

import Parser
import Lang

bigProg :: Program
bigProg = Program (
    BlockExpr [
        Read "a",
        AssignStmt "i" (BlockExpr [UnExpr Nothing (Num 0)]),
        While (BinExpr Lt (UnExpr Nothing (Ident "i")) (UnExpr Nothing (Ident "a"))) (BlockExpr [
            IfStmt (UnExpr (Just Not) (Ident "i")) (BlockExpr [
                Write (UnExpr Nothing (Ident "a")), AssignStmt "i" (BlockExpr [BinExpr Plus (UnExpr Nothing (Ident "i")) (UnExpr Nothing (Num 1))])
            ]) (Just $ BlockExpr [
                AssignStmt "i" (BlockExpr[BinExpr Plus (UnExpr Nothing (Ident "i")) (UnExpr Nothing (Num 2))])
            ])
        ]),
        Read "b",
        Write (UnExpr Nothing Tru)
    ])

main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [parseTests]

parseTests = testGroup "parseTests"
    [
        testCase "Assign test" $ Right (Program (BlockExpr [AssignStmt "a" (BlockExpr [UnExpr Nothing (Num 3)])])) @=? parse "{a={3}}",
        testCase "Read/Write test" $ Right (Program (BlockExpr [Read "a", Write (UnExpr Nothing (Ident "a"))])) @=? parse "{read( a) ; write  ( a )}",
        testCase "Arithmetic test" $ Right (Program
                                            (BlockExpr
                                                [BinExpr Eq
                                                    (BinExpr Plus
                                                        (UnExpr Nothing (Ident "a"))
                                                        (UnExpr Nothing (Num 2)))
                                                    (BinExpr Minus
                                                        (BinExpr Plus
                                                            (UnExpr Nothing (Num 2))
                                                            (BinExpr Mult
                                                                (UnExpr Nothing (Ident "b"))
                                                                (UnExpr Nothing (Num 3))))
                                                        (UnExpr (Just Neg) (Num 3)))])) @=? parse "{a+2==(2+b*3)--3}",
        testCase "if+expr test" $ Right (Program (BlockExpr [IfStmt (Read "a") (BlockExpr [Write (UnExpr (Just Not) (Ident "a"))]) Nothing])) @=? parse "{if (read(a)) { write(!a) }}",
        testCase "while test" $ Right (Program (BlockExpr [While (UnExpr Nothing Tru) (BlockExpr [UnExpr Nothing (Num 5)]), Write (BinExpr Le (UnExpr Nothing Fls) (UnExpr Nothing Tru))])) @=? parse "{while(true){5};write(false <= true)}",
        testCase "empty block expr test" $ assertBool "should fail" (isLeft $ parse "{}"),
        testCase "names test" $ Right (Program (BlockExpr [UnExpr Nothing (Ident "iffy"), UnExpr Nothing (Ident "reader"), UnExpr Nothing (Ident "writer"), UnExpr Nothing (Ident "else_123")])) @=? parse "{iffy;reader;writer;else_123}",
        testCase "print and parse" $ Right bigProg @=? parse (printer bigProg)
    ]