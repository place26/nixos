[[ $TMUX = "" ]] && export TERM="xterm-256color"

# enable GPG pinentry signing
export GPG_TTY=$(tty)

# Personal prompt setting: simplicity is best
# 참조: https://www.youtube.com/watch?v=nEvsWQrKVcQ
# use git status info
autoload -Uz vcs_info
precmd() { vcs_info }
precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:git:*' formats 'on branch %b '
setopt PROMPT_SUBST

# Old green and red
# PROMPT='%F{040}%n%f @ %F{166}%m%f   %F{031}${PWD/#$HOME/~}%f ${vcs_info_msg_0_}
# %{$fg_bold[white]%}>%{$reset_color%} '

PROMPT='%F{117}%n%f  %F{221}%m%f   %F{038}${PWD/#$HOME/~}%f ${vcs_info_msg_0_}
%{$fg_bold[white]%}>%{$reset_color%} '

# Format the git branch name in the prompt
zstyle ':vcs_info:git:*' formats 'on %F{011} %b%f'

# history
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=80000

source ${HOME}/.zsh_plugins.sh

# alias 설정
alias ll="exa -alhgs type --group-directories-first"
alias ls="exa"

# remove all .DS_Store files recursively
# -H option : search include hidden files.
alias rmds='fd -IH '^\.DS_Store$' -tf -X rm'

# vim 설치 후 기존 macos vim (/usr/bin/vim)이 실행되는 것을 방지 
# alias vim='/opt/homebrew/Cellar/vim/9.0.1600/bin/vim'
# 위의 설정은 버전이 바뀔경우 다시 수정해야 함.
# 아래의 설정은 ln으로 관리되는 vim을 alias로 지정하여 버전이 바뀔경우에도 괜찮음
if (command -v brew && brew list --formula | grep -c vim ) > /dev/null 2>&1; then
    alias vim="$(brew --prefix vim)/bin/vim"
fi

# Bundle zsh plugins via antibody
alias update-antibody='antibody bundle < $HOME/.zsh_plugins.txt > $HOME/.zsh_plugins.sh'
 
# List out all globally installed npm packages
alias list-npm-globals='npm list -g --depth=0'

# Adds better handling for `rm` using trash-cli
# https://github.com/sindresorhus/trash-cli
# You can empty the trash using the empty-trash command
# alias rm = 'trash'
# https://github.com/sindresorhus/empty-trash-cli

alias gcob='git branch | fzf | xargs git checkout'

# FZF : use fd for file search engine
# -tf : type filesi, H include hidden files, .git 폴더는 제외
# export FZF_DEFAULT_COMMAND='fd -tf --exclude ".git"'

# FZF use ripgrep for file search engine
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --margin=1 --padding=1"

export BAT_THEME="gruvbox-dark"

# nix
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
