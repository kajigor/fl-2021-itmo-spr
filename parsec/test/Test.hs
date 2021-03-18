{-# OPTIONS_GHC -Wno-deferred-type-errors #-}

import AstStmt
import LParser hiding (parse)
import Test.Hspec
import Test.Hspec.Megaparsec
import Text.Megaparsec
-- helpers

readStmt = Read "x"

writeStmt = Write (BinOp Plus (BinOp Minus (Ident "x") (BinOp Pow (Num 10) (Num 2))) (Num 5))

assignStmt = Assign "x" (Num 420)

ifElseStmt = If condition (Seq [assignStmt]) (Just (Seq [Assign "x" (BinOp Minus (Ident "x") (Num 100))]))
  where condition = BinOp Ge (Ident "x") (Num 10)

ifStmt = If condition (Seq [assignStmt]) Nothing
  where condition = BinOp Neq (Ident "x") (Num 10)

whileStmt = While condition (Seq [Write (Ident "x")])
  where condition = Num 1

stmtSeq = Seq [readStmt, ifStmt, ifElseStmt, whileStmt, writeStmt]

prog = Program stmtSeq

main :: IO ()
main = hspec $
  describe "L Parser Tests" $ do
    describe "Parser and Print Composition" $ do
      it "test composition" $
        parse progParser "" (printer prog) `shouldParse` prog
    describe "Success" $ do
      it "correct assign num" $
        parse progParser "" "a = 1;" `shouldParse` Program (Seq [Assign "a" (Num 1)])
      it "correct assign statement 1" $
        parse progParser "" "x = 1 + 2 * (1+a);" `shouldParse` Program (Seq [Assign "x" (BinOp Plus (Num 1) (BinOp Mult (Num 2) (BinOp Plus (Num 1) (Ident "a"))))])
      it "correct assign statement 2" $
        parse progParser "" "a = (1+5) *x ^ 10;" `shouldParse` Program (Seq [Assign "a" (BinOp Mult (BinOp Plus (Num 1) (Num 5)) (BinOp Pow (Ident "x") (Num 10)))])
      it "correct statement read" $
      	parse progParser "" ">> x;" `shouldParse` Program (Seq [readStmt])
      it "correct statement write" $
	    parse progParser "" "<< (x - 10^2)+ 5;" `shouldParse` Program (Seq [writeStmt])
      it "correct statement if" $
	    parse progParser "" "if (x != 10) begin x = 420; end" `shouldParse` Program (Seq [ifStmt])
      it "correct statement if-else" $
	    parse progParser "" "if (x >= 10) begin x = 420; end else begin x = x -100; end" `shouldParse` Program (Seq [ifElseStmt])
      it "correct statement while" $
	    parse progParser "" "while (1) begin << x; end" `shouldParse` Program (Seq [whileStmt])
      it "correct comment" $
	    parse progParser "" "while (1) begin << x; end // >> x;" `shouldParse` Program (Seq [whileStmt])
    describe "Error" $ do
      it "incorrect code: no ;" $
        parse progParser "" `shouldFailOn` "a=1"
      it "incorrect code: no begin" $
        parse progParser "" `shouldFailOn` "if (x != 10) x = 420; end"
      it "incorrect code: no end" $
        parse progParser "" `shouldFailOn` "if (x != 10) begin x = 420;"
      it "incorrect code: unknown command" $
        parse progParser "" `shouldFailOn` "write 1+25;"