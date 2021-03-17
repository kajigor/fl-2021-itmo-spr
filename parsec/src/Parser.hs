module Parser where

import qualified Megaparsec.Parser ( parse )
import AstStmt ( Program )

data ParserType = Mega deriving (Show)

parse :: ParserType -> String -> Either String Program
parse Mega = Megaparsec.Parser.parse

