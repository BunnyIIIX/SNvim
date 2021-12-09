""=>> Markdown
syn match   timeFlag              '@.\{-}\(\s\{1}\|$\)'
syn match   additionalFlag        '#.\{-}\(\s\{1}\|$\)'

hi def link timeFlag              VimwikiHeader6 
hi def link additionalFlag        VimwikiHeader4

hi VimwikiCheckBoxDone guifg=#8BE9FD gui=italic
hi VimwikiHeader1 guifg=#a957ec gui=bold
hi VimwikiHeader2 guifg=#a6e22e gui=bold
hi VimwikiHeader3 guifg=#ff5c57 gui=bold
hi VimwikiHeader4 guifg=#F01f6f gui=bold
hi VimwikiHeader5 guifg=#74fa90 gui=bold
" hi VimwikiHeader5 guifg=#c3a5e6 gui=bold
hi VimwikiHeader6 guifg=#00FFFF gui=bold

" hi htmlH1      gui=bold guifg=#a957ec
" hi htmlH2      gui=bold guifg=#a6e22e
" hi htmlH3      gui=bold guifg=#ff5c57
" hi htmlH4      gui=bold guifg=#F01f6f
" hi htmlH5      gui=bold guifg=#c3a5e6
" hi htmlH6      gui=bold guifg=#74fa90

""{{{ =>> COLORS
"" #11091E  
"" #1f1f1f
"" #403c58
"" #faebd7
"" #ffe9aa
"" #f1ca93
"" #f9b093
"" #f9a093
"" #ffb378
"" #efaf4f
"" #ff5c57
"" #ea6f91
"" #f8509f
"" #f92672
"" #F01f6f
"" #9f1663
"" #c3a5e6
"" #ae81ff
"" #af7aff
"" #a061ff
"" #a957ec
"" #6400b0  
"" #a1efe4
"" #5af0c4
"" #74fa90 
"" #0fff89
"" #94fa60
"" #a6e22e
"" #04ea40
"" #4ff2f1 
"" #66d9ef 
"" #2a9aa1 
"" #34738e 
"" #4747f8 

""" Yuki
"" #FF00FF
"" #BD93F9
"" #00FFFF
"" #00FF00
"" #e67e22
"" #fc5d7c
"" "}}}
"
" vim: set foldmethod=marker :
