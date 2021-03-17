module Printer where

import Common.Syntax
    ( Program(..), Stmt(..), Expr(..), Operator(..) )

toOp :: Operator -> String
toOp Pow = "^"
toOp Mult = "*"
toOp Div = "/"
toOp Plus = "+"
toOp Minus = "-" 
toOp Eq = "=="
toOp Neq = "!="
toOp Le = "<="
toOp Lt = "<"
toOp Ge = ">="
toOp Gt = ">"

printExpr :: Expr -> String
printExpr (Ident sname) = sname
printExpr (Num num) = show num
printExpr (BinOp op ex1 ex2) =
    let op' = toOp op
        ex1' = printExpr ex1
        ex2' = printExpr ex2
        res = ex1' ++ " " ++ op' ++ " " ++ ex2'
    in if isAssoc op then "(" ++ res ++ ")" else res

isAssoc :: Operator -> Bool
isAssoc Pow = True
isAssoc Mult = True
isAssoc Plus = True
isAssoc Minus = True
isAssoc Div = True
isAssoc _ = False

printIf :: Expr -> Stmt -> Maybe Stmt -> String
printIf ex stmt1 (Just stmt2) = "if (" ++ printExpr ex ++ ") " 
        ++ printStmt stmt1 ++ "else " 
        ++ printStmt stmt2
printIf ex stmt1 Nothing = "if (" ++ printExpr ex ++ ") " 
        ++ printStmt stmt1

printWhile :: Expr -> Stmt -> String
printWhile ex stmt = "while (" ++ printExpr ex ++ ") " 
    ++ printStmt stmt

printStmt :: Stmt -> String
printStmt stmt =
    case stmt of
        Ignore ex         -> printExpr ex ++ ";"
        If ex stmt1 stmt2 -> printIf ex stmt1 stmt2
        While ex stmt     -> printWhile ex stmt           
        Read var          -> "read " ++ var ++ ";"                
        Write ex          -> "write " ++ printExpr ex ++ ";"       
        Assign var ex     -> var ++ " = " ++ printExpr ex ++ ";"       
        Seq xs            -> "{" ++ foldr (\stmt str -> printStmt stmt ++ " " ++ str) "}" xs

printer :: Program -> String
printer (Program stmt) = printStmt stmt
