module ParserProvider where

import Parser
import Common.Syntax

data ParserType = Mega deriving (Show)

parse :: ParserType -> String -> Either String Program
parse Mega = Parser.parser