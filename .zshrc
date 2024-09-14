# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zコマンドを使う
# なければclone
if [[ ! -d ~/z_cmd ]];then
  git clone https://github.com/rupa/z ~/z_cmd
fi
source ~/z_cmd/z.sh

# tmux内でCtrl + A が ^A に化けるので追加
bindkey -e  # emacsモードで使う

# HomeBrew管理にしたのでコメントアウト
# 念のために削除はしない
# alias mysql="/usr/local/mysql/bin/mysql"
alias algo="cd /Users/mac_toshi/Documents/0_Algo/1_algo_training"
alias vplug="cd ~/.config/nvim/dein/plugins"

# ngrok疎通用
alias ngrok-s="ngrok http --domain=fit-lobster-upright.ngrok-free.app 3000 --region=us"
# docker環境最新化
alias d-wake="d-c run --rm app bundle install && d-c run --rm app bin/yarn install && d-c run --rm app bin/rails db:migrate && d-c up app worker shakapacker-dev-server"
# webへの移動
alias v1="cd ~/enpay_dir/web"
# enpayへの移動
alias v2="cd ~/enpay_dir/enpay"
# enapyの起動
alias d-wake-v2="cd ~/enpay_dir/enpay && d-c up"
# admin-frontのVSCode起動
alias v-admin="cd ~/enpay_dir/enpay/admin-front && code ."
# back-endのVSCode起動
alias v-back="cd ~/enpay_dir/enpay/back-end && code ."
# enpayレポジトリのcdkのVSCode起動
alias v-cdk="cd ~/enpay_dir/enpay/cdk && code ."


# Git Alias
alias g='git'
alias gst='git status'
alias gc-m='git commit -m'
alias gc='git checkout'
### git treeは個人的に作成したgit logの整形alias(.gitconfig参照)
alias gtree='git tree'

# Push all changes to current branch
gcom () {
    git add . && git status
    echo "Type commit comment" && read comment;
    git commit -m ${comment} && git push origin HEAD
}
# Git pull and come back to dev branch
gpdv () {
   git checkout master
   git pull
   git checkout develop
}

# npm Alias
# nodebrewでnpmは管理
# /Users/mac_toshi/.nodebrew/node/v16.13.1/libにモジュールある
alias ni='npm install'
alias nu='npm uninstall'
alias nis="npm install --save"
alias nus="npm uninstall --save"

# # django Alias
# alias pmr='python manage.py runserver'
# alias sva='source venv/bin/activate'
# alias pmmm='python manage.py makemigrations'
# alias pmmg='python manage.py migrate'

# zsh Alias
alias vz='vi ~/.zshrc'
alias sz='source ~/.zshrc'
alias vs="code"

# #　Docker Alias
alias dk='docker'
alias dbp='docker builder prune'
alias d-c='docker compose'
alias dcb='docker compose build'
alias dcud='docker compose up -d'
alias dsall='docker stop $(docker ps -q)'
alias dsp-v='docker system prune --volumes'
alias d-cex='docker compose exec'
alias d-crrm='docker compose run --rm'

# expo alias
alias exr='expo r'
alias exr-c='expo r -c'

# yarn alias
alias ya='yarn'

# Linux Alias
alias j='z'
alias ls='eza'
alias lssp='eza -lahg --icons --git --time-style=long-iso'
alias lssp-t='eza -lahg --icons --git --time-style=long-iso --sort oldest'
alias cat='bat'
alias prs='procs'
alias ...="cd ../.."
alias ....="cd ../../../"
alias hist='cat ~/.zsh_history'

# Vim Alias
alias vi="nvim"
alias vv='vi ~/.vimrc'
alias vini='vi ~/.config/nvim/init.vim'
alias cdein='cd ~/.cache/dein'
alias tm='tmux'
alias tmks='tmux kill-session'
alias tmls='tmux ls'

# Expo Alias
kcash(){
        echo "Are you sure in your project dir?" && read answer;
        if [ "$answer" = "y" ]; then
                rm -rf node_modules
                yarn install
                watchman watch-del-all
                rm -fr $TMPDIR/haste-map-*
                rm -rf $TMPDIR/metro-cache
                echo "Cache is gone."
        fi
}

# cdなしでディレクトリ移動
setopt auto_cd

# path
export PATH="/opt/homebrew/opt/mysql/bin:$PATH"
# export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix zstd)/lib

### nodeがHomebrewに入っているのもあって、nodebrewのnodeを参照するように設定
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PGDATA='/usr/local/var/postgres'
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export PATH="$PATH:$HOME/.fzf/bin"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 30% --border'

### open Java Developers Kit(open JDKのパス)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# ### GOのPATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export EDITOR=nvim

export AWS_DEFAULT_REGION=ap-northeast-1

# direnv用
eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# [[]]は条件式の意味(testと等価)
# -dはあるディレクトリが存在しているかをtestする
# [[ -d ~/.rbenv  ]] && \
#   export PATH=${HOME}/.rbenv/bin:${PATH} && \
#   eval "$(rbenv init -)"


#####################################################################
# zplugが無ければgitからclone
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# zplugを使う
if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
fi

# 自分自身をプラグインとして管理
zplug "zplug/zplug", hook-build:'zplug --self-manage'√

# ここに使いたいプラグインを書いておく
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
# # # gitのエイリアス多すぎてつかいづらいからコメントアウト : 自分で定義するときに参考に使う分にはいいかも https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
# zplug "plugins/git", from:oh-my-zsh
# zplug "peterhurford/git-aliases.zsh"
zplug "zsh-users/zsh-history-substring-search"
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "marzocchi/zsh-notify"

zplug "stedolan/jq", from:gh-r, as:command \
    | zplug "b4b4r07/emoji-cli", if:"which jq"

# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose

###########

# zsh補間
fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit -u
# 補完結果を移動できる
zstyle ':completion:*:default' menu select=1
# 補完候補に色つける
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true

# 実行に15秒以上かかるコマンドの終了を通知させる
zstyle ':notify:*' command-complete-timeout 20

autoload -Uz colors ; colors

# 重複するコマンドのhistory削除
setopt hist_ignore_all_dups
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# コマンドのスペルを訂正する
setopt correct
# カッコの対応などを自動的に補完する
setopt auto_param_keys
# cdを使わずにディレクトリを移動できる
setopt auto_cd
# $ cd - でTabを押すと、ディレクトリの履歴が見れる
setopt auto_pushd
# 補完リストの表示間隔を狭くする
setopt list_packed
# '#' 以降をコメントとして扱う
setopt interactive_comments

# ビープ音の停止
setopt no_beep
# ビープ音の停止(補完時)
setopt nolistbeep

source "/usr/local/opt/zsh-git-prompt/zshrc.sh"
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX=" ]"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{ %G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[magenta]%}%{x%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[red]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]%}%{-%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{✔%G%}"
RPROMPT='$(git_super_status)'

 # prompt
PROMPT='%F{magenta}%m@%n%f %F{blue}%~%f$ '

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To use shell integration, run this .zsh file whenever starting terminal
source ~/.iterm2_shell_integration.zsh
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
