" logファイル展開するときに，mattnさんのlet s:dir = expand('<sfile>:h:h') .
" '/resources/' 使えないかなぁ?
let s:save_cpo = &cpo
set cpo&vim

function! latex#run()
  if executable('platex')
    if expand("%:e") != 'tex'
      echomsg 'texファイルを展開できません'
    else
      call delete(expand("%:p:r").'.dvi')
      let latexfile = expand("%")
      call system("platex ".latexfile)
      if filereadable(expand("%:p:r").'.dvi')
        call system("dvipdfmx ".expand('%:r'))
        execute "OpenBrowser" expand("%:p:r"). '.pdf'
      else
        echo 'error'
        execute(':vnew '.expand("%:p:r").'.log')
      endif
    endif
  else 
    echomsg 'platexが入っていません'
    finish
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
