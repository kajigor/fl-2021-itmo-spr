module Megaparsec.Parser where


import Control.Monad.Combinators.Expr
    ( makeExprParser, Operator(InfixR) )
import Data.Void (Void(..))
import Text.Megaparsec
    ( (<|>),
      runParser,
      errorBundlePretty,
      between,
      many,
      Parsec,
      MonadParsec(try) )
import Text.Megaparsec.Char
    ( alphaNumChar, char, letterChar, lowerChar, space1, upperChar )
import qualified Text.Megaparsec.Char.Lexer as L
import AstStmt

type Parser = Parsec Void String

parse :: String -> Either String Program
parse _ = Left "kek"






















