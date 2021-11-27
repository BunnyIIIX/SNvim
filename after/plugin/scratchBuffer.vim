func! ScratchBuffer() abort
    if bufname() == ''
        setl buftype=nofile
        setl bufhidden=hide
        setl noswapfile
    endif
endfunc

augroup vim_start | au!
    au VimEnter * call ScratchBuffer()
augroup end
