# vseq.vim

##INTRODUCTION
*vseq* is a Vim plugin for generating sequential number vertically.  


##USAGE
Select same numbers vertically by visual block select, and execute `:VSeqIncrDec`. So, the numbers become the incremented sequence by decimal number.  

For example,  

```
0  0  0  0  
0  0  0  0  
0  0  0  0  
0  0  0  0  
0  0  0  0  
0  0  0  0  
0  0  0  0  
0  0  0  0  
0  0  0  0  
0  0  0  0  
0  0  0  0  
```

the previous buffer becomes the following by   

- Select 1st column and execute `:VseqIncrDec`.
- Select 2nd column and execute `:VseqIncrHex`.
- Select 3rd column and execute `:VseqDecrDec`.
- Select 4th column and execute `:VseqDecrHex`.

```
 0  0 10  a  
 1  1  9  9  
 2  2  8  8  
 3  3  7  7  
 4  4  6  6  
 5  5  5  5  
 6  6  4  4  
 7  7  3  3  
 8  8  2  2  
 9  9  1  1  
10  a  0  0  
```

###RECOMMENDED
If vim-operator-user plugin is installed, key-mappings by operator is avaliable. The key-mappings can do *dot-repeat*.

vim-operator-user plugin
https://github.com/kana/vim-operator-user


##INTERFACE
###VARIABLES
- `g:vseq#upper_case` ( default value: = 0 )

If `g:vseq#upper_case` is 1, the alphabets of hex number become uppercase.  


- `g:vseq#padding_right` ( default value: = 0 )

If `g:vseq#padding_right` is 1, the padding by white space becomes right side of number.  
The option is ignored at zero padding.  


###COMMANDS
- `:VSeqIncrOct`
- `:VSeqIncrDec`
- `:VSeqIncrHex`

Generate sequential number incrementally.  
Suffix( Oct/Dec/Hex ) means the radix of number.  


- `:VSeqDecrOct`
- `:VSeqDecrDec`
- `:VSeqDecrHex`

Generate sequential number decrementally.  
Suffix( Oct/Dec/Hex ) means the radix of number.  


###KEY-MAPPINGS
- `<Plug>(vseq-incr-oct)`
- `<Plug>(vseq-incr-dec)`
- `<Plug>(vseq-incr-hex)`

call `:VSeqIncrOct` / `:VSeqIncrDec` / `:VSeqIncrHex`.  


- `<Plug>(vseq-decr-oct)`
- `<Plug>(vseq-decr-dec)`
- `<Plug>(vseq-decr-hex)`

call `:VSeqDecrOct` / `:VSeqDecrDec` / `:VSeqDecrHex`.  


- `<Plug>(operator-vseq-incr-oct)`
- `<Plug>(operator-vseq-incr-dec)`
- `<Plug>(operator-vseq-incr-hex)`

call `:VSeqIncrOct` / `:VSeqIncrDec` / `:VSeqIncrHex` as operator.  
This mappings is only avaibale when vim-operator-user plugin is installed.  


- `<Plug>(operator-vseq-decr-oct)`
- `<Plug>(operator-vseq-decr-dec)`
- `<Plug>(operator-vseq-decr-hex)`

call `:VSeqDecrOct` / `:VSeqDecrDec` / `:VSeqDecrHex` as operator.  
This mappings is only avaibale when vim-operator-user plugin is installed.  

