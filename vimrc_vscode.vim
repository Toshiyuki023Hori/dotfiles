" https://www.pc-gear.com/post/vscode-vim-vimrc/
" vimrcの設定のやつ

" ------------------------------------------------------------
"  key bind
" ------------------------------------------------------------
" Normal Mode
" conoremap => NormalModeのkey-mapping
" <C = Contorl キー
noremap <Space>cl :close<CR>                                    " ウインドウを閉じる

" VSCodeみたいにOptionとhjkl(要は矢印キー)でカーソルある行を移動できる
" けど、VSCodeにおいては普通に使えるからdisableにする
" nnoremap ∆ :m .+1<CR>==
" nnoremap ˚ :m .-2<CR>==
" inoremap ∆ <Esc>:m .+1<CR>==gi
" inoremap ˚ <Esc>:m .-2<CR>==gi
" vnoremap ∆ :m '>+1<CR>gv=gv
" vnoremap ˚ :m '<-2<CR>gv=gv

" jキーを二度押しでESCキー
inoremap <silent> jj <Esc>

"バッファの移動
noremap <silent> bn :bnext<CR>
noremap <silent> bp :bprev<CR>
" bdの後に数字を入れる
noremap <silent> bd :bdelete
" :bの後に数字を入れてbuffer移動
noremap <silent> <Space>b :b

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

" # キーでカーソル下の単語を指定文字に置換
