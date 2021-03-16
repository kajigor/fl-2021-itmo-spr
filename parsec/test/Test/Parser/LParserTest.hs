module Test.Parser.LParserTest where

import Test.Tasty.HUnit (Assertion, assertBool)

import Test.Common (syntaxError, parsingSuccess)

import LangParser.LParser (parser)
import LangParser.AstStmt 

unit_assignError :: Assertion 
unit_assignError = do
    syntaxError parser "__________sadfdf := 10;"
    syntaxError parser "_asd := 10;"
    syntaxError parser "sdaf#$%@sfsd := 10;"
    syntaxError parser "sdafsfss$%d := 10;"
    syntaxError parser "asd d := 10;"
    syntaxError parser "if d := 10;"
    syntaxError parser "else d := 10;"
    syntaxError parser "d := 10"
    syntaxError parser "d = 10;"

unit_assignSuccess :: Assertion 
unit_assignSuccess = do 
    parsingSuccess parser "a := 10;" (Program (Seq [Assign "a" (Num 10)]))
    parsingSuccess parser "a := 10 + 19;" (Program (Seq [Assign "a" (BinOp Plus (Num 10) (Num 19))]))
    parsingSuccess parser "a := 1+2*3*4;" (Program (Seq [Assign "a" (BinOp Plus (Num 1) (BinOp Mult (BinOp Mult (Num 2) (Num 3)) (Num 4)))]))
    parsingSuccess parser "a := 1-2/3/4;" (Program (Seq [Assign "a" (BinOp Minus (Num 1) (BinOp Div (BinOp Div (Num 2) (Num 3)) (Num 4)))]))
    parsingSuccess parser "a := (1+ 2) *3+ 4;" (Program (Seq [Assign "a" (BinOp Plus (BinOp Mult (BinOp Plus (Num 1) (Num 2)) (Num 3)) (Num 4))]))
    parsingSuccess parser "a := (1+2)*3 ^ 4;" (Program (Seq [Assign "a" (BinOp Mult (BinOp Plus (Num 1) (Num 2)) (BinOp Pow (Num 3) (Num 4)))]))

unit_statementError :: Assertion 
unit_statementError = do
    syntaxError parser "if (a > b) {a := b;} else {"
    syntaxError parser "if (a > b) {a := b;} else }"
    syntaxError parser "if (a > b) {a := b;} {}"
    syntaxError parser "(a > b) {a := b;} else {}"
    syntaxError parser "while (a > b) {a := b;}"
    syntaxError parser "if () {a := b;} else {}"
    syntaxError parser "loop () {a := b;}"
    syntaxError parser "in var"
    syntaxError parser "i var;"
    syntaxError parser "in a + 1;"
    syntaxError parser "out a + ;"
    syntaxError parser "out a + 1"
    syntaxError parser "ou a + 1;"

unit_statementSuccess :: Assertion 
unit_statementSuccess = do
    parsingSuccess parser "loop ((a <= 10) || (b)) { a := a + 1; b := b * c; if (a > b) {a := b;}else {}}" (Program (Seq [While (BinOp Or (BinOp Le (Ident "a") (Num 10)) (Ident "b")) (Seq [Seq [Assign "a" (BinOp Plus (Ident "a") (Num 1)),Assign "b" (BinOp Mult (Ident "b") (Ident "c")),If (BinOp Gt (Ident "a") (Ident "b")) (Seq [Seq [Assign "a" (Ident "b")]]) (Just (Seq []))]])]))
    parsingSuccess parser "in a;" (Program (Seq [Read "a"]))
    parsingSuccess parser "in asdfad;" (Program (Seq [Read "asdfad"]))
    parsingSuccess parser "out asdfad;" (Program (Seq [Write (Ident "asdfad")]))
    parsingSuccess parser "out (1 + 2 * 3) ^ 5;" (Program (Seq [Write (BinOp Pow (BinOp Plus (Num 1) (BinOp Mult (Num 2) (Num 3))) (Num 5))]))
    parsingSuccess parser "out a && (1 + 2 * 3) ^ 5;" (Program (Seq [Write (BinOp And (Ident "a") (BinOp Pow (BinOp Plus (Num 1) (BinOp Mult (Num 2) (Num 3))) (Num 5)))]))
    parsingSuccess parser "loop (20) {}" (Program (Seq [While (Num 20) (Seq [])]))
    parsingSuccess parser "if (a < b) {} else {}" (Program (Seq [If (BinOp Lt (Ident "a") (Ident "b")) (Seq []) (Just (Seq []))]))


checkCondition :: Program -> Bool 
checkCondition ast = case parser (show ast) of 
  Right b -> ast == b
  Left a -> False 


progList :: [Program]
progList = [
    (Program (Seq [While (BinOp Or (BinOp Le (Ident "a") (Num 10)) (Ident "b")) (Seq [Seq [Assign "a" (BinOp Plus (Ident "a") (Num 1)),Assign "b" (BinOp Mult (Ident "b") (Ident "c")),If (BinOp Gt (Ident "a") (Ident "b")) (Seq [Seq [Assign "a" (Ident "b")]]) (Just (Seq []))]])])),
    (Program (Seq [Read "a"])),
    (Program (Seq [Read "asdfad"])),
    (Program (Seq [Write (BinOp And (Ident "a") (BinOp Pow (BinOp Plus (Num 1) (BinOp Mult (Num 2) (Num 3))) (Num 5)))])),
    (Program (Seq [If (BinOp Lt (Ident "a") (Ident "b")) (Seq []) (Just (Seq []))]))]



unit_identical :: Assertion 
unit_identical = do
    assertBool "Should be identical ast after print" $ and (fmap checkCondition progList)