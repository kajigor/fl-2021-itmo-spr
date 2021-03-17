{-# OPTIONS_GHC -Wno-deferred-type-errors #-}

import LParser.AstStmt hiding (main)
import LParser.LParser
import Test.Hspec
import Test.Hspec.Megaparsec
import Text.Megaparsec

-- "if (1+3==4){x=33;}    while(1){y=3;} var x; read(x);  print(x^2);"

opPlus3And3 = BinOp Plus (Num 2) (Num 3)

stmtDecl = Decl "x"

stmtRead = Read "x"

stmtAssign = Assign "x" (Num 100)

stmtIf = If (Ident "x") (Seq [Ignore (Num 66), Ignore opPlus3And3]) Nothing

stmtWhile = While (Num 1) (Seq [Write $ Ident "x"])

stmtIfElse = If (Ident "x") (Seq [Ignore (Num 66)]) $ (Just $ Seq [stmtWhile])

stmtSeq = Seq [stmtDecl, stmtAssign, stmtRead, stmtIf, stmtIfElse]

prog = Program stmtSeq

main :: IO ()
main = hspec $
  describe "L Parser" $ do
    describe "Parse Expression" $ do
      it "correct var" $
        parse pVar "" "aaa" `shouldParse` "aaa"
      it "incorrect var" $
        parse pVar "" `shouldFailOn` "1aaa"
      it "empty expression" $
        parse pExpr "" `shouldFailOn` ""
      it "simple expression" $
        parse pExpr "" "1" `shouldParse` Num 1
      it "binary expression" $
        parse pExpr "" "1+4" `shouldParse` BinOp Plus (Num 1) (Num 4)
      it "priority test" $
        parse pExpr "" "1+4*5" `shouldParse` BinOp Plus (Num 1) (BinOp Mult (Num 4) (Num 5))
      it "variable test" $
        parse pExpr "" "1+4*5/xxx" `shouldParse` BinOp Plus (Num 1) (BinOp Div (BinOp Mult (Num 4) (Num 5)) (Ident "xxx"))
      it "braces test" $
        parse pExpr "" "(1+4)*5" `shouldParse` BinOp Mult (BinOp Plus (Num 1) (Num 4)) (Num 5)
      it "equality" $
        parse pExpr "" "1+y==5" `shouldParse` BinOp Eq (BinOp Plus (Num 1) (Ident "y")) (Num 5)
    describe "Parse Statement" $ do
      it "declaration stamemnt" $
        parse pSeq "" "var x;" `shouldParse` Seq [Decl "x"]
      it "assign stamemnt" $
        parse pSeq "" "var x;x= 4^y;" `shouldParse` Seq [Decl "x", Assign "x" (BinOp Pow (Num 4) (Ident "y"))]
      it "assign stamemnt" $
        parse pSeq "" "var x;x= 4^y;" `shouldParse` Seq [Decl "x", Assign "x" (BinOp Pow (Num 4) (Ident "y"))]
      it "test if" $
        parse pSeq "" "var x;x= 4^y;\nif(x==4){print(x);}" `shouldParse` Seq [Decl "x", Assign "x" (BinOp Pow (Num 4) (Ident "y")), If (BinOp Eq (Ident "x") (Num 4)) (Seq [Write (Ident "x")]) Nothing]
      it "test if else" $
        parse pSeq "" "var x;x= 4^y;\nif(x==4){print(x);}   else {read(x);}" `shouldParse` Seq [Decl "x", Assign "x" (BinOp Pow (Num 4) (Ident "y")), If (BinOp Eq (Ident "x") (Num 4)) (Seq [Write (Ident "x")]) (Just (Seq [Read "x"]))]
      it "test while" $
        parse pSeq "" "while(1) {x=x+1;print(x);}print(1);" `shouldParse` Seq [While (Num 1) (Seq [Assign "x" (BinOp Plus (Ident "x") (Num 1)), Write (Ident "x")]), Write (Num 1)]
    describe "Test composition" $ do
      it "test composition" $
        parse pProgram "" (printer prog) `shouldParse` prog