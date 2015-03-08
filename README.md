# Comma-Separated Lists

comma-separated lists(CSL) stores data in nested-text like comma-separated values(CSV).

# Examples

### valid

```
[foo,1,2,bar]
foo,1,2,bar
```

```
[[1,one],[2,two],[3,three]]
[1,one],[2,two],[3,three]
```

```
[hoge,piyo,tyun,[1,2,3],[a,[b,c,[d],e,[],f]]]
hoge,piyo,tyun,[1,2,3],[a,[b,c,[d],e,[],f]]
```

these are equal data.

```
foo,1,2,bar
```

```
[1,one],[2,two],[3,three]
```

```
hoge,piyo,tyun,[1,2,3],[a,[b,c,[d],e,[],f]]
```

# BNF
```
csl = open record close EOF | record
list = OPEN CLOSE | OPEN record CLOSE
record = field *(COMMA field)
field = list | escaped | non-escaped
escaped = DQUOTE *(TEXTDATA | OPEN | CLOSE | COMMA | CR | LF | 2DQUOTE) DQUOTE
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
