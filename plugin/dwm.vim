" Check for Vim version 700 or greater {{{1
if v:version < 700
  echo "Sorry, dwm.vim ".g:dwm_version."\nONLY runs with Vim 7.0 and greater."
  finish
endif



command! DWMRotateCounterclockwise  silent call dwm#DWM_Rotate(0)
command! DWMRotateClockwise         silent call dwm#DWM_Rotate(1)

command! DWMNew                     silent call dwm#DWM_New()
command! -bang DWMClose             silent execute dwm#DWM_Close('<bang>')
command! DWMFocus                   silent call dwm#DWM_Focus()

command! DWMGrowMaster              silent call dwm#DWM_GrowMaster()
command! DWMShrinkMaster            silent call dwm#DWM_ShrinkMaster()




nnoremap <silent> <Plug>DWMRotateCounterclockwise :DWMRotateCounterclockwise<CR>
nnoremap <silent> <Plug>DWMRotateClockwise        :DWMRotateClockwise<CR>

nnoremap <silent> <Plug>DWMNew   :DWMNew<CR>
nnoremap <silent> <Plug>DWMClose :DWMClose<CR>
nnoremap <silent> <Plug>DWMFocus :DWMFocus<CR>

nnoremap <silent> <Plug>DWMGrowMaster   :DWM_GrowMaster<CR>
nnoremap <silent> <Plug>DWMShrinkMaster :call DWM_ShrinkMaster()<CR>

if !exists('g:dwm_map_keys')
  let g:dwm_map_keys = 1
endif

if g:dwm_map_keys
  nnoremap <C-J> <C-W>w
  nnoremap <C-K> <C-W>W

  if !hasmapto('<Plug>DWMRotateCounterclockwise')
    nmap <C-,> <Plug>DWMRotateCounterclockwise
  endif
  if !hasmapto('<Plug>DWMRotateClockwise')
    nmap <C-.> <Plug>DWMRotateClockwise
  endif

  if !hasmapto('<Plug>DWMNew')
    nmap <C-N> <Plug>DWMNew
  endif
  if !hasmapto('<Plug>DWMClose')
    nmap <C-C> <Plug>DWMClose
  endif
  if !hasmapto('<Plug>DWMFocus')
    nmap <C-@> <Plug>DWMFocus
    nmap <C-Space> <Plug>DWMFocus
  endif

  if !hasmapto('<Plug>DWMGrowMaster')
    nmap <C-L> <Plug>DWMGrowMaster
  endif
  if !hasmapto('<Plug>DWMShrinkMaster')
    nmap <C-H> <Plug>DWMShrinkMaster
  endif
endif
