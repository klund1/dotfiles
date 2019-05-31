function! ChangeGitRebaseCommand(command)
  exec "normal! 0cw" . a:command
  exec "normal! 0"
endfunction

nnoremap P :call ChangeGitRebaseCommand("pick")<cr>
nnoremap R :call ChangeGitRebaseCommand("reword")<cr>
nnoremap E :call ChangeGitRebaseCommand("edit")<cr>
nnoremap S :call ChangeGitRebaseCommand("squash")<cr>
nnoremap F :call ChangeGitRebaseCommand("fixup")<cr>
nnoremap D :call ChangeGitRebaseCommand("drop")<cr>

nnoremap q :wq<cr>
nnoremap A :cq!<cr>
