" インストールディレクトリの指定
" vimではletで代入
" s: をつけることで、vimスクリプトないのみのローカルの変数として定義
" expand() はシェルの持っている変数や環境変数を展開できる。
" 環境変数を展開できないときはそのままになる。
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml_file = expand('~/.config/nvim/dein') . '/plugins.toml'
let s:toml_dir = expand('~/.config/nvim/dein/plugins')
" Vimにはruntime <filename>というコマンドがあり、指定したファイルを読み込み、Vimスクリプトとして実行させることができます
" runtimeコマンドで指定するファイルは’runtimepath’上から読むよということを言っているようです。
" dein.vim ディレクトリがruntimepathに入っていない場合、追加
if match( &runtimepath, '/dein.vim' ) == -1
  " dein_repo_dir で指定した場所に dein.vim が無い場合、git cloneしてくる
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath+=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" dein の設定
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)
  " 各プラグインのtomlを読み込む
	call dein#load_toml( s:toml_dir . '/init_plugin.toml', {'lazy': 0} )
	call dein#load_toml( s:toml_dir . '/lazy_plugin.toml', {'lazy': 1} )
    " 詳しくは下記記事参照だが、treesitterのみ個別でロード
    " https://zenn.dev/mkobayashime/articles/nvim-treesitter-dein
    " これだと [dein] Vim(source):E5113: Error while calling lua chunk: /home/mkobayashime/.config/nvim/plugins/nvim-treesitter.lua:1: module 'nvim-treesitter.configs' not found: というエラーが出てしまう
    " hook_add は plugin が読み込まれたあとで実行されるわけではないので、nvim-treesitter.confis なんてものはないと怒られている
    call dein#add('nvim-treesitter/nvim-treesitter', {'merged': 0})
	
  call dein#end()
	call dein#save_state()
endif


" 各プラグインのインストールチェック（なかったら自動的に追加される）
if dein#check_install()
	call dein#install()
endif

" GitHub apt file.
let s:dein_github_api_token = './init_api_token.vim'

" dein_github_api_tokenが有るか確認する。
if filereadable(s:dein_github_api_token)

    " ここで、g:dein#install_github_api_tokenにPATをセットする。
    let g:dein#install_github_api_token = readfile(s:dein_github_api_token)[0]
endif

" Check for plugin updates on github graphQL api.{{{
command! DeinUpdate call dein#check_update(v:true)
" }}}

" vim初期起動時の設定を読み込む
source ~/.config/nvim/init_config.vim

" treesitterの設定読み込み
source ~/dotfiles/dein/plugins/nvim-treesitter.lua

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
" Use <Tab> and <S-Tab> to navigate the completion list: https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-and-s-tab-to-navigate-the-completion-list
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 確実に<TAB>を使えるように(=他のプラグインから上書きされないように)下記の記述を追加
" Use <C-@> on vim
inoremap <silent><expr> <c-@> coc#refresh()
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-cr-to-confirm-completion
" coc.nvimの補完をEnterで確定させるために、
" 下記を追加することで他のプラグインからのマッピングを防ぐ
" You have to remap <cr> to make it confirms completion.
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" キーマッピングの単純化のためコメントアウト
" To make <cr> select the first completion item and confirm the completion when no item has been selected:
"   " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Option + J/K
" ∆ == J
" ˚ == K
" VSCodeみたいにOptionとhjkl(要は矢印キー)でカーソルある行を移動できる
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

"C++のコードフォーマッタの自動実行
function! s:clang_format()
  let now_line = line(".")
  exec ":%! clang-format"
  exec ":" . now_line
endfunction

if executable('clang-format')
  augroup cpp_clang_format
    autocmd!
    autocmd BufWrite,FileWritePre,FileAppendPre *.[ch]pp call s:clang_format()
  augroup END
endif

