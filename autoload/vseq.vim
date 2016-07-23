"===========================================================
"FILE   : vseq.vim
"AUTHOR : dalance <dalance@gamil.com>
"LICENSE: MIT license
"===========================================================

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:vseq#upper_case')
    let g:vseq#upper_case = 0
endif

if !exists('g:vseq#padding_right')
    let g:vseq#padding_right = 0
endif

function! vseq#vseq(is_rev, base) range
    let pos_beg = getpos("'<")
    let pos_end = getpos("'>")
    let pos_cur = getpos(".")

    let diff_line  = pos_cur[1] - pos_beg[1]
    let diff_col   = pos_cur[2] - pos_beg[2]
    let pos_beg[1] = pos_beg[1] + diff_line
    let pos_beg[2] = pos_beg[2] + diff_col
    let pos_end[1] = pos_end[1] + diff_line
    let pos_end[2] = pos_end[2] + diff_col

    call s:vseq(pos_beg, pos_end, a:is_rev, a:base)
endfunction

function! s:vseq(pos_beg, pos_end, is_rev, base)
    let col      = a:pos_beg[2]
    let line_beg = a:pos_beg[1]
    let line_end = a:pos_end[1]

    let fmt = (a:base==16) ? "x" : (a:base==10) ? "d" : (a:base==8)? "o" : "d"
    let fmt = g:vseq#upper_case ? toupper(fmt) : fmt

    let matches = {}

    let max_width    = 0
    let min_beg      = 100000
    let max_end      = 0
    let zero_padding = 0
    for i in range(line_beg, line_end)
        call cursor(i, col)
        let buf = getline(i)

        let [match_beg, match_end] = s:search_digit(buf, col, a:base)
        if match_beg == -1 && match_end == -1
            return
        endif

        let str_src = strpart(buf, match_beg, match_end - match_beg)
        let num_src = str2nr(str_src, a:base)
        let num_dst = a:is_rev ? num_src + line_end - i : num_src + i - line_beg

        let str_dst = printf("%".fmt, num_dst)

        let max_width = len(str_dst) > max_width ? len(str_dst) : max_width
        let min_beg   = match_beg    < min_beg   ? match_beg    : min_beg
        let max_end   = match_end    > max_end   ? match_end    : max_end
        let zero_padding = (str_src[0] == "0" && len(str_src) > 1) ? 1 : zero_padding

        let matches[i] = [str_src, num_dst]
    endfor

    for i in range(line_beg, line_end)
        call cursor(i, col)
        let buf = getline(i)

        let [str_src, num_dst] = matches[i]

        let fmt_flag = zero_padding ? "0" : g:vseq#padding_right ? "-" : ""
        let str_dst = printf("%" . fmt_flag . max_width . fmt, num_dst)

        let buf_head = (min_beg != 0) ? buf[0:min_beg-1] : ""
        let buf_tail = buf[max_end:]

        call setline(i, buf_head . str_dst . buf_tail )
    endfor

    call setpos(".", a:pos_beg)
endfunction

function! s:search_digit(buf, col, base)
    let i = 0
    let pat = (a:base==16) ? '[0-9a-fA-F]\+' : '\d\+' 
    while i < len(a:buf) && i != -1
        let match_beg = match(a:buf, pat, i)
        let match_end = matchend(a:buf, pat, i)
        if match_beg <= a:col - 1 && a:col - 1 < match_end
            return [match_beg, match_end]
        endif
        let i = match_end
    endwhile

    return [-1, -1]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
