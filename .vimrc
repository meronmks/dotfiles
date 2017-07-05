" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" 入力中のコマンドをステータスに表示する
set showcmd

"見た目系
" 行番号を表示
set number
" ステータスラインを常に表示
set laststatus=2
" シンタックスハイライトON
syntax on
" ステータスバーに表示するもの設定
set statusline=%F%m%r%h%w%={[FORMAT=%{&ff}][ENC=%{&fileencoding}][POS=%l/%L,%v]}
" Tab系
" Tab文字を半角スペースにする
set expandtab
" タブ幅を4にする
set tabstop=4

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
