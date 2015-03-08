module Main where

import Data.List
import Control.Applicative ((<*), (*>), (<$>))
import Text.Parsec
import Text.Parsec.String

data CSL = CSLValue String | CSLList [CSL]
    deriving Show

csl :: Parser CSL
csl = array <|> record

array :: Parser CSL
array = try (open *>  (return . CSLList $ []) <* close)
        <|>
        open *> record <* close

record :: Parser CSL
record = CSLList <$> sepBy field comma

field :: Parser CSL
field = array <|> CSLValue <$> escaped <|> CSLValue <$> nonEscaped


escaped :: Parser String
escaped = do
    dquote
    vals <- many (textdata <|> open <|> close <|> comma <|> cr <|> lf <|> try (dquote *> dquote))
    dquote
    return $ vals

nonEscaped :: Parser String
nonEscaped = many textdata


textdata :: Parser Char
textdata = oneOf ("! " ++ ['#'..'+'] ++ ['-'..'Z'] ++ "\\" ++ ['^'..'~'])
comma = char ','
open :: Parser Char
open = char '\x5b'
close :: Parser Char
close = char '\x5d'
crlf = cr *> lf
lf = char '\x0d'
cr = char '\x0d'
dquote = char '"'
