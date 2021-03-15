module Parser where

import LangParser.LParser ( parser ) 
import LangParser.AstStmt ( Program )

data ParserType = MyLangParser
    deriving (Show)

parse :: ParserType -> String -> Either String Program
parse MyLangParser = LangParser.LParser.parser
