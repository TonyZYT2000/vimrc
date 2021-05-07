# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
#zinit light zsh-users/zsh-syntax-highlighting
zinit light zdharma/fast-syntax-highlighting

# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma/history-search-multi-word

# Load some OMZ plugins
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/git.zsh

# load p10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# alias
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias llh='ls -alFh'
