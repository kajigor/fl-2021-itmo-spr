module Lang where

type Var = String

data BinOp = Plus
           | Minus
           | Div
           | Mult
           | Mod
           | Eq
           | Neq
           | Le
           | Ge
           | Lt
           | Gt
           | And
           | Or deriving Eq

instance Show BinOp where
    show Plus = "+"
    show Minus = "-"
    show Div = "/"
    show Mult = "*"
    show Mod = "%"
    show Eq = "=="
    show Neq = "!="
    show Le = "<="
    show Ge = ">="
    show Lt = "<"
    show Gt = ">"
    show And = "&&"
    show Or = "||"
    

data UnOp = Not | Neg deriving Eq

instance Show UnOp where
    show Neg = "-"
    show Not = "!"

data BasicExpr = Ident Var | Num Int | Tru | Fls deriving Eq

instance Show BasicExpr where
    show (Ident name) = name
    show (Num num) = show num
    show Tru = "true"
    show Fls = "false"

data Expr = UnExpr (Maybe UnOp) BasicExpr
          | BinExpr BinOp Expr Expr 
          | IfStmt Expr BlockExpr (Maybe BlockExpr)
          | AssignStmt Var BlockExpr
          | Write Expr
          | Read Var
          | While Expr BlockExpr deriving Eq
          
newtype BlockExpr = BlockExpr [Expr] deriving Eq

instance Show Expr where
    show (UnExpr unop bexpr) = maybe "" show unop ++ show bexpr
    show (BinExpr op left right) = "(" ++ show left ++ ")" ++ show op ++ "(" ++ show right ++ ")"
    show (IfStmt condition truBranch flsBranch) = "if (" ++ show condition ++ ")" ++ show truBranch ++ maybe "" (\x -> "else " ++ show x) flsBranch
    show (AssignStmt name value) = name ++ "=" ++ show value
    show (Write expr) = "write(" ++ show expr ++ ")"
    show (Read name) = "read(" ++ name ++ ")"
    show (While condition body) = "while (" ++ show condition ++ ")" ++ show body
    
instance Show BlockExpr where
    show (BlockExpr exprs) = "{" ++ showWithSC exprs ++ "}"
        where showWithSC [] = ""
              showWithSC [expr] = show expr
              showWithSC (expr:exprs) = show expr ++ ";" ++ showWithSC exprs

newtype Program = Program BlockExpr deriving Eq
instance Show Program where
    show (Program p) = show p


printer :: Program -> String
printer = show
