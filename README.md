# Comma-Separated Lists

comma-separated lists(CSL) stores data in nested-text like comma-separated values(CSV).

# Examples

```
[foo,[1,2],bar]
```

# BNF
```
csl = record || array
array = OPEN record CLOSE | OPEN CLOSE
record = field *(COMMA field)
field = escaped | non-escaped | array
escaped = DQUOTE *(TEXTDATA | COMMA | OPEN | CLOSE | CR | LF | 2DQUOTE) DQUOTE
non-escaped = *TEXTDATA
TEXTDATA = %x20-21 | %x23-%x2b | %x2d-%x5a | %x5c | %x5e-%x7e
COMMA = '%x2c'
OPEN = '['
CLOSE = ']'
CRLF = CR LF
CR = %x0d
LF = %x0a
DQUOTE = %x22
```
