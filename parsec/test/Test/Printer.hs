module Test.Printer where

import Common.Syntax
import Printer
import Test.Tasty.HUnit (Assertion (..), (@?=))

prog1 = Program $ Seq [Read "a", While (BinOp Le (Ident "a") (Num (-100))) (Seq [Write (Ident "a"), Assign "a" (BinOp Minus (Ident "a") (Num 1))])]
prog2 = Program $ Seq [If (BinOp Eq (Ident "b") (Num 1)) (Write (Ident "b")) Nothing]
prog3 = Program $ Seq []
prog4 = Program $ Ignore (BinOp Plus (Num 1) (Num 2))
prog5 = Program $ Seq [ Write (BinOp Pow (Num 1) (Num 2)), Read "den", If (BinOp Neq (Ident "den") (Num 0)) (If (BinOp Ge (Ident "enum") (Ident "den")) (Write (BinOp Div (Ident "enum") (Ident "den"))) (Just (Read "enum"))) (Just (Seq [Ignore (BinOp Gt (Num 1) (Ident "enum")), Assign "enum" (BinOp Mult (BinOp Plus (Ident "enum") (Ident "den")) (Num 1))])) ]

unit_printer :: Assertion
unit_printer = do
  printer prog1 @?= "{read a; while (a <= -100) {write a; a = (a - 1); } }"
  printer prog2 @?= "{if (b == 1) write b; }"
  printer prog3 @?= "{}"
  printer prog4 @?= "(1 + 2);"
  printer prog5 @?= "{write (1 ^ 2); read den; if (den != 0) if (enum >= den) write (enum / den);else read enum;else {1 > enum; enum = ((enum + den) * 1); } }"

