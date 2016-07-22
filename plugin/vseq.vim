"===========================================================
"FILE   : vseq.vim
"AUTHOR : dalance <dalance@gamil.com>
"LICENSE: MIT license
"===========================================================

if exists('g:loaded_vseq')
    finish
endif
let g:loaded_vseq = 1

let s:save_cpo = &cpo
set cpo&vim

command! -range VSeqIncrOct :call vseq#vseq(0, 8 )
command! -range VSeqIncrDec :call vseq#vseq(0, 10)
command! -range VSeqIncrHex :call vseq#vseq(0, 16)
command! -range VSeqDecrOct :call vseq#vseq(1, 8 )
command! -range VSeqDecrDec :call vseq#vseq(1, 10)
command! -range VSeqDecrHex :call vseq#vseq(1, 16)

vnoremap <Plug>(vseq-incr-oct) :VSeqIncrOct<CR>
vnoremap <Plug>(vseq-incr-dec) :VSeqIncrDec<CR>
vnoremap <Plug>(vseq-incr-hex) :VSeqIncrHex<CR>
vnoremap <Plug>(vseq-decr-oct) :VSeqDecrOct<CR>
vnoremap <Plug>(vseq-decr-dec) :VSeqDecrDec<CR>
vnoremap <Plug>(vseq-decr-hex) :VSeqDecrHex<CR>

try
    call operator#user#define_ex_command( "vseq-incr-oct", "VSeqIncrOct" )
    call operator#user#define_ex_command( "vseq-incr-dec", "VSeqIncrDec" )
    call operator#user#define_ex_command( "vseq-incr-hex", "VSeqIncrHex" )
    call operator#user#define_ex_command( "vseq-decr-oct", "VSeqDecrOct" )
    call operator#user#define_ex_command( "vseq-decr-dec", "VSeqDecrDec" )
    call operator#user#define_ex_command( "vseq-decr-hex", "VSeqDecrHex" )
catch
endtry

let &cpo = s:save_cpo
unlet s:save_cpo
