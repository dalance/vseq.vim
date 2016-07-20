"===========================================================
"FILE   : vseq.vim
"AUTHOR : dalance <dalance@gamil.com>
"LICENSE: MIT license
"===========================================================

let s:save_cpo = &cpo
set cpo&vim

function! vseq#vseq(is_rev, is_hex) range
    let pos_beg = getpos("'<")
    let pos_end = getpos("'>")
    let pos_cur = getpos(".")

    let diff_line  = pos_cur[1] - pos_beg[1]
    let diff_col   = pos_cur[2] - pos_beg[2]
    let pos_beg[1] = pos_beg[1] + diff_line
    let pos_beg[2] = pos_beg[2] + diff_col
    let pos_end[1] = pos_end[1] + diff_line
    let pos_end[2] = pos_end[2] + diff_col

    call s:vseq(pos_beg, pos_end, a:is_rev, a:is_hex)
endfunction

function! s:vseq(pos_beg, pos_end, is_rev, is_hex)
    let col      = a:pos_beg[2]
    let line_beg = a:pos_beg[1]
    let line_end = a:pos_end[1]

    let base = a:is_hex ? 16 : 10
    let fmt  = a:is_hex ? "x" : "d"

    let max_width = 0
    for i in range(line_beg, line_end)
        call cursor(i, col)
        let buf = getline(i)

        let [match_beg, match_end] = s:search_digit(buf, col, a:is_hex)

        let part = strpart(buf, match_beg, match_end - match_beg)
        let num_src = str2nr(part, base)
        let num_dst = a:is_rev ? num_src + line_end - i : num_src + i - line_beg

        let rep = printf("%".fmt, num_dst)

        let max_width = len(rep)  > max_width ? len(rep)  : max_width
        let max_width = len(part) > max_width ? len(part) : max_width
    endfor

    for i in range(line_beg, line_end)
        call cursor(i, col)
        let buf = getline(i)

        let [match_beg, match_end] = s:search_digit(buf, col, a:is_hex)

        let part = strpart(buf, match_beg, match_end - match_beg)
        let num_src = str2nr(part, base)
        let num_dst = a:is_rev ? num_src + line_end - i : num_src + i - line_beg

        let fmt_zero = part[0] == "0" && len(part) > 1 ? "0" : ""
        let rep = printf("%" . fmt_zero . max_width . fmt, num_dst)

        let buf_head = match_beg != 0 ? buf[0:match_beg-1] : ""
        let buf_tail = buf[match_end:]

        call setline(i, buf_head . rep . buf_tail )
    endfor

    call setpos(".", a:pos_beg)
endfunction

function! s:search_digit(buf, col, is_hex)
    let i = 0
    let pat = a:is_hex ? ' *[0-9a-fA-F]\+' : ' *\d\+' 
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
