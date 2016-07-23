# vseq.vim

##INTRODUCTION
*vseq* is a Vim plugin for generating sequential number vertically.  

[![asciicast](https://asciinema.org/a/3i5yptlh2udbl9bkvrteee1ek.png)](https://asciinema.org/a/3i5yptlh2udbl9bkvrteee1ek)

##USAGE
Select same numbers vertically by visual block select, and execute `:VSeqIncrDec`. So, the numbers become the incremented sequence by decimal number.  
Unlike `g<CTRL-A>`, this plugin can select radix manually, and automatically aligns by white space or zero padding.

For example,  

```
0 0 0 0 00
0 0 0 0 00
0 0 0 0 00
0 0 0 0 00
0 0 0 0 00
0 0 0 0 00
0 0 0 0 00
0 0 0 0 00
0 0 0 0 00
0 0 0 0 00
0 0 0 0 00
```

the previous buffer becomes the following by   

- Select 1st column and execute `:VseqIncrDec`.
- Select 2nd column and execute `:VseqIncrHex`.
- Select 3rd column and execute `:VseqDecrDec`.
- Select 4th column and execute `:VseqDecrHex`.
- Select 5th column and execute `:VseqIncrDec`.

```
 0 0 10 a 00
 1 1  9 9 01
 2 2  8 8 02
 3 3  7 7 03
 4 4  6 6 04
 5 5  5 5 05
 6 6  4 4 06
 7 7  3 3 07
 8 8  2 2 08
 9 9  1 1 09
10 a  0 0 10
```

###RECOMMENDED
If vim-operator-user plugin is installed, key-mappings by operator is avaliable. The key-mappings can do *dot-repeat*.

vim-operator-user plugin

https://github.com/kana/vim-operator-user


##INTERFACE
###VARIABLES
#### `g:vseq#upper_case` ( default value: = 0 )

If `g:vseq#upper_case` is 1, the alphabets of hex number become uppercase.  


#### `g:vseq#padding_right` ( default value: = 0 )

If `g:vseq#padding_right` is 1, the padding by white space becomes right side of number.  
The option is ignored at zero padding.  


###COMMANDS
- `:VSeqIncrOct` : Generate sequential number incrementally by octal format.
- `:VSeqIncrDec` : Generate sequential number incrementally by decimal format.
- `:VSeqIncrHex` : Generate sequential number incrementally by hexadecimal format.
- `:VSeqDecrOct` : Generate sequential number decrementally by octal format.
- `:VSeqDecrDec` : Generate sequential number decrementally by decimal format.
- `:VSeqDecrHex` : Generate sequential number decrementally by hexadecimal format.

###KEY-MAPPINGS
- `<Plug>(vseq-incr-oct)` : call `:VSeqIncrOct`.  
- `<Plug>(vseq-incr-dec)` : call `:VSeqIncrDec`.
- `<Plug>(vseq-incr-hex)` : call `:VSeqIncrHex`.
- `<Plug>(vseq-decr-oct)` : call `:VSeqDecrOct`.  
- `<Plug>(vseq-decr-dec)` : call `:VSeqDecrDec`.
- `<Plug>(vseq-decr-hex)` : call `:VSeqDecrHex`.

###KEY-MAPPINGS AS OPERATOR
The following mappings is only avaibale when vim-operator-user plugin is installed.  

- `<Plug>(operator-vseq-incr-oct)` : call `:VSeqIncrOct` as operator.  
- `<Plug>(operator-vseq-incr-dec)` : call `:VSeqIncrDec` as operator.
- `<Plug>(operator-vseq-incr-hex)` : call `:VSeqIncrHex` as operator.
- `<Plug>(operator-vseq-decr-oct)` : call `:VSeqDecrOct` as operator.  
- `<Plug>(operator-vseq-decr-dec)` : call `:VSeqDecrDec` as operator.
- `<Plug>(operator-vseq-decr-hex)` : call `:VSeqDecrHex` as operator.
