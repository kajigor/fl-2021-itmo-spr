module Parser where

import LParser
import AstStmt (Program)

data ParserType = L deriving (Show)

parse :: ParserType -> String -> Either String Program
parse L = LParser.parse

