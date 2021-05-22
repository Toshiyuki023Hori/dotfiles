# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias mysql="/usr/local/mysql/bin/mysql"
alias mysql="/usr/local/mysql/bin/mysql"
alias mysql="/usr/local/mysql/bin/mysql"
alias mysql="/usr/local/mysql/bin/mysql"
alias mysql="/usr/local/mysql/bin/mysql"
alias mysql="/usr/local/mysql/bin/mysql"

# Git Alias
alias gcma='git checkout master'
alias gcdv='git checkout develop'
alias gs='git status'
alias ga-a='git add --all'
alias gc-b='git checkout -b'
alias gc-m='git commit -m'
alias gpoh='git push origin HEAD'
alias gl='git log'
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
alias ni='npm install'
alias nu='npm uninstall'
alias nis="npm install --save"
alias nus="npm uninstall --save"
alias nst='npm start'

# django Alias
alias pmr='python manage.py runserver'
alias sva='source venv/bin/activate'
alias pmmm='python manage.py makemigrations'
alias pmmg='python manage.py migrate'

# Vim Alias
alias vz='code ~/.zshrc'
alias sz='source ~/.zshrc'
alias vs="code"
alias ...="cd ../.."
alias ....="cd ../../../"

# cdなしでディレクトリ移動
setopt auto_cd

# path
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"


#####################################################################
# zplugが無ければgitからclone
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# zplugを使う
source ~/.zplug/init.zsh

# 自分自身をプラグインとして管理
zplug "zplug/zplug", hook-build:'zplug --self-manage'

# ここに使いたいプラグインを書いておく
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/git", from:oh-my-zsh
zplug "peterhurford/git-aliases.zsh"
zplug "zsh-users/zsh-history-substring-search"
zplug "romkatv/powerlevel10k", as:theme, depth:1

# oh-my-zsh をサービスと見なして、
# そこからインストールする
zplug "plugins/git", from:oh-my-zsh

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
