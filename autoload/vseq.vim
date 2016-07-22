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

    let max_width = 0
    for i in range(line_beg, line_end)
        call cursor(i, col)
        let buf = getline(i)

        let [match_beg, match_end] = s:search_digit(buf, col, a:base)

        let part = strpart(buf, match_beg, match_end - match_beg)
        let num_src = str2nr(part, a:base)
        let num_dst = a:is_rev ? num_src + line_end - i : num_src + i - line_beg

        let rep = printf("%".fmt, num_dst)

        let max_width = len(rep)  > max_width ? len(rep)  : max_width
        let max_width = len(part) > max_width ? len(part) : max_width
    endfor

    for i in range(line_beg, line_end)
        call cursor(i, col)
        let buf = getline(i)

        let [match_beg, match_end] = s:search_digit(buf, col, a:base)

        let part = strpart(buf, match_beg, match_end - match_beg)
        let num_src = str2nr(part, a:base)
        let num_dst = a:is_rev ? num_src + line_end - i : num_src + i - line_beg

        let fmt_flag = (part[0] == "0" && len(part) > 1) ? "0" : g:vseq#padding_right ? "-" : ""
        let rep = printf("%" . fmt_flag . max_width . fmt, num_dst)

        let buf_head = (match_beg != 0) ? buf[0:match_beg-1] : ""
        let buf_tail = buf[match_end:]

        call setline(i, buf_head . rep . buf_tail )
    endfor

    call setpos(".", a:pos_beg)
endfunction

function! s:search_digit(buf, col, base)
    let i = 0
    let pat = (a:base==16) ? ' *[0-9a-fA-F]\+' : ' *\d\+' 
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
