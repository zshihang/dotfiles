source ~/.zplug/init.zsh || { git clone https://github.com/zplug/zplug ~/.zplug && source ~/.zplug/init.zsh }

# plugins
zplug "lib/history", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "djui/alias-tips"
zplug "supercrabtree/k"
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh
zplug "zsh-users/zsh-completions"
zplug "shihan9/d073f03dee894f64eb9a30b64e4954ad", from:gist # fzf
zplug "mafredri/zsh-async", from:github

# theme
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zplug check || zplug install

zplug load


# aliases
alias vimconfig="vim ~/.vimrc"
alias vimconfiglocal="vim ~/.vimrc.local"
alias zshconfig="vim ~/.zshrc"
alias zshconfiglocal="vim ~/.zshrc.local"
alias tmuxconfig="vim ~/.tmux.conf"
alias tmuxconfiglocal="vim ~/.tmux.conf.local"
alias bashconfig="vim ~/.bash_profile"
alias jn="jupyter notebook"

source ~/.zshrc.local
