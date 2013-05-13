" Exit quickly if already running
if exists("g:dwm_version") || &cp
  finish
endif

let g:dwm_version = "0.1.2"


" All layout transformations assume the layout contains one master pane on the
" left and an arbitrary number of stacked panes on the right
" +--------+--------+
" |        |   S1   |
" |        +--------+
" |   M    |   S3   |
" |        +--------+
" |        |   S3   |
" +--------+--------+

" Move the current master pane to the stack
function! dwm#DWM_Stack(clockwise)
  1wincmd w
  if a:clockwise
    " Move to the top of the stack
    wincmd K
  else
    " Move to the bottom of the stack
    wincmd J
  endif
  " At this point, the layout *should* be the following with the previous master
  " at the top.
  " +-----------------+
  " |        M        |
  " +-----------------+
  " |        S1       |
  " +-----------------+
  " |        S2       |
  " +-----------------+
  " |        S3       |
  " +-----------------+
endfunction

" Add a new buffer
function! dwm#DWM_New()
  " Move current master pane to the stack
  call dwm#DWM_Stack(1)
  " Create a vertical split
  vert topleft new
  call dwm#DWM_ResizeMasterPaneWidth()
endfunction

" Move the current window to the master pane (the previous master window is
" added to the top of the stack)
function! dwm#DWM_Focus()
  let l:curwin = winnr()
  call dwm#DWM_Stack(1)
  execute l:curwin . "wincmd w"
  wincmd H
  call dwm#DWM_ResizeMasterPaneWidth()
endfunction

" Close the current window
function! dwm#DWM_Close(bang)
  let close = 'close' . a:bang
  if winnr() == 1
    " Close master panel.
    return close . ' | wincmd H | call dwm#DWM_ResizeMasterPaneWidth()'
  else
    return close
  end
endfunction

function! dwm#DWM_ResizeMasterPaneWidth()
  " resize the master pane if user defined it
  if exists('g:dwm_master_pane_width')
    if type(g:dwm_master_pane_width) == type("")
      execute 'vertical resize ' . ((str2nr(g:dwm_master_pane_width)*&columns)/100)
    else
      execute 'vertical resize ' . g:dwm_master_pane_width
    endif
  endif
endfunction

function! dwm#DWM_GrowMaster()
  if winnr() == 1
    execute "vertical resize +1"
  else
    execute "vertical resize -1"
  endif
  if exists("g:dwm_master_pane_width") && g:dwm_master_pane_width
    let g:dwm_master_pane_width += 1
  else
    let g:dwm_master_pane_width = ((&columns)/2)+1
  endif
endfunction

function! dwm#DWM_ShrinkMaster()
  if winnr() == 1
    execute "vertical resize -1"
  else
    execute "vertical resize +1"
  endif
  if exists("g:dwm_master_pane_width") && g:dwm_master_pane_width
    let g:dwm_master_pane_width -= 1
  else
    let g:dwm_master_pane_width = ((&columns)/2)-1
  endif
endfunction

function! dwm#DWM_Rotate(clockwise)
  call dwm#DWM_Stack(a:clockwise)
  if a:clockwise
    wincmd W
  else
    wincmd w
  endif
  wincmd H
  call dwm#DWM_ResizeMasterPaneWidth()
endfunction
