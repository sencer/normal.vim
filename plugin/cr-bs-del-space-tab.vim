" Name:
"
"    cr-bs-del-space-tab.vim
"
"
" Copyright:
" 
"    Jochen Baier, 2006 (email@Jochen-Baier.de)
"
" Version: 0.02
"
" Last Modified: Jun 28, 2006
"
" Use CR-TAB-DEL-SPACE-TAB in Normal Mode like in Insert Mode"
"
" Use the keys: "Return, Backspace, Delete, Space, Tab" in Normal-Mode
" like you are used from Insert-Mode. Very usefull to do some code cleanup in Normal-Mode,
" or to make some place for copy/paste action. Or just to delete a line fast and easy.
" (or insert a new line.....).
"
"
" Installation: 
"
" * Drop cr-bs-del-space-tab.vim into your plugin directory           
"

function! Delete_key(...)

  let line=getline (".")
  if line=~'^\s*$'
    execute "normal dd"
    return
  endif

  execute "normal dl"

endfunction


function! BS_key(...)

  let column = col(".")
  "call Decho ("colum: " . column)

  if col(".") == 1
    execute "normal i\<BS>\<Esc>"
  else
    execute "normal dh" 
  endif

endfunction       


function! TAB_key (...)

  "call Decho ("TAB_key")

  let start_pos = col(".")

  execute "normal i\<TAB>"

  let end_pos = col(".")
  let diff = end_pos - start_pos
  let counter = 0


  "ugly :)
  while 1==1
    execute "normal l"
    let counter= counter + 1
    if counter >= diff
      break
    endif
  endwhile

  execute "normal \<ESC>"

endfunction
     
function! Return_key ()

  let buftype = getbufvar(bufnr(''), '&buftype') 

  if buftype != ""
    unmap <CR>
    execute "normal \<CR>"
    nnoremap <silent> <CR> :call Return_key()<CR>
  else
    execute "normal i\<CR>\<ESC>" 
  endif

endfunction           


nnoremap <silent> <DEL> :call Delete_key()<CR>
nnoremap <silent> <CR> :call Return_key()<CR>
nnoremap <silent> <SPACE> i<SPACE><ESC>l
nnoremap <silent> <TAB> i<SPACE><SPACE><ESC>l
nnoremap <silent> <BS> :call BS_key()<CR>
