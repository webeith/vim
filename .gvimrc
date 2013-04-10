set guifont=Liberation\ Mono\ 10
cmap <S-Insert>  <C-R>+
map  <silent>  <S-Insert>  "+p
imap <silent>  <S-Insert>  <Esc>"+pa

set guifont=Liberation\ Mono\ 10
cmap <S-Insert>  <C-R>+
map  <silent>  <S-Insert>  "+p
imap <silent>  <S-Insert>  <Esc>"+pa

set guioptions+=e " включаем none-gui табы
set guioptions-=r " отключаем правый scrollbar
set guioptions-=R " отключаем правый scrollbar при вертикальном разделении окна
set guioptions-=b " отключаем нижний scrollbar 
set guioptions-=l " отключаем левый scrollbar
set guioptions-=L " отключаем левый scrollbar при вертикальном разделении окна
set guioptions-=T " отключаем панель инструментов
set guioptions-=m " отключаем меню

function ToggleFullScreen()
    if &go =~ 'e'
        exec('silent !wmctrl -r :ACTIVE: -b add,fullscreen')
        exec('set go-=e')
    else
        exec('silent !wmctrl -r :ACTIVE: -b remove,fullscreen')
        exec('set go+=e')
    endif 
endfunction

nnoremap <F11> :call ToggleFullScreen()<CR>
inoremap <F11> :call ToggleFullScreen()<CR>

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

" set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

" the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

" after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

" right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

return s
endfunction

function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let label = fnamemodify(bufname(buflist[winnr - 1]), ':t')

if label == ''
        if &buftype == 'quickfix'
          let label = '[Quickfix List]'
        else
          let label = 'NoName'
        endif
    endif

if getbufvar(buflist[winnr - 1], "&modified")
        let label = "+".label
    endif

let label = a:n.":".label

return label
endfunction

set tabline=%!MyTabLine()
