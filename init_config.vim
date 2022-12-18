" ------------------------------------------------------------
"  key bind
" ------------------------------------------------------------
" Normal Mode
" conoremap => NormalModeのkey-mapping
" <C = Contorl キー
cnoremap init<CR> :<C-u>edit ~/.config/nvim/init.vim<CR>                           " init.vim呼び出し
cnoremap config<CR> :<C-u>edit ~/.config/nvim/init_config.vim<CR>                           " init_config.vim呼び出し
cnoremap start<CR> :<C-u>edit ~/.config/nvim/dein/plugins/init_plugin.toml<CR>                           " init_plugin.toml呼び出し
cnoremap lazy<CR> :<C-u>edit ~/.config/nvim/dein/plugins/lazy_plugin.toml<CR>                           " lazy_plugin.toml呼び出し
nnoremap <Space>S :source ~/.config/nvim/init_config.vim<CR>                           " init.vim読み込み
noremap <Space>w :<C-u>w<CR>                                    " ファイル保存
noremap <Space>q :q<CR>                                         " 保存せずに閉じる
noremap <Space>cl :close<CR>                                    " ウインドウを閉じる

cnoremap ch<CR> :vs ~/dotfiles/.command_sheet.md<CR>                           ":ch入力でチートシート表示
cnoremap vz<CR> :vs ~/.zshrc<CR>                           ":vz入力で.zshrc編集

" Insert Mode
" inoremap <silent> jj <ESC>:<C-u>w<CR>:" InsertMode抜けて保存

" # ペーストの日本語文字化け対策
set encoding=UTF-8 "文字コードをUTF-8にする
set fileencoding=UTF-8 "文字コードをUTF-8にする
set termencoding=UTF-8 "文字コードをUTF-8にする

" #####表示設定#####
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
set expandtab "タブ文字の代わeにスペースを使う
set splitbelow  " 水平分割時に下に表示
set splitright  " 縦分割時を右に表示
set ruler " カーソルの位置表示
set cursorline " カーソルハイライト
syntax on "コードの色分け
set tabstop=4 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set laststatus=2 "常にステータスを表示
set autoindent "改行時に自動的にインデントを適用
set list "タブ、空白、改行の可視化
set showcmd "入力中のコマンドを表示
set nowrap "折り返しを無効

" #####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索結果をハイライト表示
set incsearch
set wildmenu "コマンドラインモードの補完を見やすく

" jキーを二度押しでESCキー
inoremap <silent> jj <Esc>

"バッファの移動
noremap <silent> bn :bnext<CR>
noremap <silent> bp :bprev<CR>
" bdの後に数字を入れる
noremap <silent> bd :bdelete
" :bの後に数字を入れてbuffer移動
noremap <silent> <Space>b :b

"===== その他 =====
"履歴を10000件保存
set history=10000

"入力モード時のカーソル移動
inoremap <C-m> <Down>
inoremap <C-,> <Up>
inoremap <C-n> <Left>
inoremap <C-.> <Right>

"コピーをクリップボードに保存
vnoremap y "+y
nnoremap yy "+yy

" Ctr + c でカーソルのあるバッファをwindowを閉じずに削除
noremap <C-c> :bp\|bd #<CR>

" スペース2回でカーソル下の単語をハイライト
nnoremap <silent> <Space><Space> :let @/ = '\<' . expand('<cword>') . '\>'<CR>:set hlsearch<CR>

" # キーでカーソル下の単語を指定文字に置換
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>

" ハイライトを削除しつつ画面再描画
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" ファイル拡張子ごとにタブの設定切り替え
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.ts setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.tsx setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.jsx setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.vue setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.md setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

