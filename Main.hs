module Main where

import Data.List
import Text.Parsec
import Text.Parsec.String

data CSL = CSLValue String | CSLArray [CSL]
    deriving Show

csl :: Parser CSL
csl = cArray <|> cValue

cArray :: Parser CSL
cArray = do
    char '['
    vals <- csl `sepBy` char ','
    char ']'
    return $ CSLArray vals

cValue :: Parser CSL
cValue = do
    val <- many $ oneOf (['a'..'z'] ++ ['A'..'Z'])
    return $ CSLValue val
