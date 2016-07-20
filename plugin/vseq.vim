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

command! -range VSeq       :call vseq#vseq(0, 0)
command! -range VSeqRev    :call vseq#vseq(1, 0)
command! -range VSeqHex    :call vseq#vseq(0, 1)
command! -range VSeqHexRev :call vseq#vseq(1, 1)

vnoremap <Plug>(vseq)         :VSeq      <CR>
vnoremap <Plug>(vseq-rev)     :VSeqRev   <CR>
vnoremap <Plug>(vseq-hex)     :VSeqHex   <CR>
vnoremap <Plug>(vseq-hex-rev) :VSeqHexRev<CR>

try
    call operator#user#define_ex_command( "vseq"        , "VSeq      " )
    call operator#user#define_ex_command( "vseq-rev"    , "VSeqRev   " )
    call operator#user#define_ex_command( "vseq-hex"    , "VSeqHex   " )
    call operator#user#define_ex_command( "vseq-hex-rev", "VSeqHexRev" )
catch
endtry

let &cpo = s:save_cpo
unlet s:save_cpo
