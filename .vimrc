set tabstop=2 shiftwidth=2 expandtab
nmap <F12> :.w !sh ~/.runFromVim.sh F12 <CR>:call system('tmux set-option status-right ' . expand('%:t') . ':' . line('.') . shellescape(' %H:%M') )<CR>
nmap <PageDown> :.w !sh ~/.runFromVim.sh PageDown <CR>j:call system('tmux set-option status-right ' . expand('%:t') . ':' . line('.') . shellescape(' %H:%M') )<CR>z.
xmap <PageDown> :.w !sh ~/.runFromVim.sh PageDown <CR>:call system('tmux set-option status-right ' . expand('%:t') . ':' . line('.') . shellescape(' %H:%M') )<CR>z.`>j^
"map       <C-S-PageDown> :call system('tmux set-option status-right ' . expand('%:t') . ':' . line('.') . shellescape(' %H:%M') )<CR>z.:1,.w !sh ~/.runFromVim.sh F12
"map     <S-PageDown> :w !sh ~/.runFromVim.sh S-F12 <CR>`>:call system('tmux set-option status-right ' . expand('%:t') . ':' . line('.') . shellescape(' %H:%M') )<CR><CR>^<CR>
set paste
set tabstop=2 shiftwidth=2 expandtab
map <F4> O<ESC>jyyp:s/[^ ]/-/g<CR>/SQL> select<CR>/;<CR>j^:noh<CR>z.

"nmap § v}:.w !sh ~/.runFromVim.sh PageDown <CR>:call system('tmux set-option status-right ' . expand('%:t') . ':' . line('.') . shellescape(' %H:%M') )<CR>z.`>j^
nmap § mxvip:.w !sh ~/.runFromVim.sh Paragraph <CR><CR>`x
nmap ° mxvip:.w !sh ~/.runFromVim.sh Paragraph <CR><CR>}jz.


