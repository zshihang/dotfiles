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
zplug "mafredri/zsh-async"
zplug "zsh-users/zsh-completions"
zplug "shihan9/d073f03dee894f64eb9a30b64e4954ad", from:gist # fzf

# theme
zplug "sindresorhus/pure", use:pure.zsh, as:theme

zplug check || zplug install

zplug load

# aliases
alias vimconfig="vim ~/.vimrc"
alias zshconfig="vim ~/.zshrc"
alias tmuxconfig="vim ~/.tmux.conf"
alias bashconfig="vim ~/.bash_profile"
alias jn="jupyter notebook"

source ~/.zshrc.local
