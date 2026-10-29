# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
#zinit light zsh-users/zsh-syntax-highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma-continuum/history-search-multi-word

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

# environment variable
export EDITOR=vim

# agent stuff
# personal & edu codex
alias codex-personal='CODEX_HOME="$HOME/.codex-personal" codex'
alias codex-edu='CODEX_HOME="$HOME/.codex-edu" codex'

# personal & edu kilo
alias kilo='HERDR_AGENT=kilo command kilo'
kilo-personal() {
    HERDR_AGENT=kilo command kilo "$@"
}

kilo-edu() {
    local root="$HOME/.kilo-edu"

    HERDR_AGENT=kilo \
    XDG_CONFIG_HOME="$root/config" \
    XDG_DATA_HOME="$root/data" \
    XDG_STATE_HOME="$root/state" \
    XDG_CACHE_HOME="$root/cache" \
    KILO_NO_DAEMON=1 \
    command kilo "$@"
}

# ==========================================
# Sync Codex: Personal -> Edu
# ==========================================

sync-codex-edu() {
    local src="$HOME/.codex-personal"
    local dst="$HOME/.codex-edu"
    local name

    if [[ ! -d "$src" ]]; then
        echo "Codex Personal directory not found: $src"
        return 1
    fi

    mkdir -p "$dst" || return 1

    echo "Syncing Codex Personal -> Edu..."

    # Configuration and global instructions
    for name in config.toml AGENTS.md; do
        if [[ -f "$src/$name" ]]; then
            cp -p "$src/$name" "$dst/$name"
            echo "  Copied: $name"
        fi
    done

    # Skills, custom prompts, and rules
    for name in skills prompts rules; do
        if [[ -d "$src/$name" ]]; then
            mkdir -p "$dst/$name"
            rsync -a "$src/$name/" "$dst/$name/"
            echo "  Synced: $name/"
        fi
    done

    echo "Codex sync complete."
}


# ==========================================
# Sync Kilo: Personal -> Edu
# ==========================================

sync-kilo-edu() {
    local src="$HOME/.config/kilo"
    local dst="$HOME/.kilo-edu/config/kilo"
    local name

    if [[ ! -d "$src" ]]; then
        echo "Kilo Personal configuration not found: $src"
        return 1
    fi

    mkdir -p "$dst" || return 1

    echo "Syncing Kilo Personal -> Edu..."

    # Configuration and instructions
    for name in \
        kilo.json \
        kilo.jsonc \
        opencode.json \
        opencode.jsonc \
        config.json \
        tui.json \
        tui.jsonc \
        AGENTS.md \
        CLAUDE.md \
        CONTEXT.md
    do
        if [[ -f "$src/$name" ]]; then
            cp -p "$src/$name" "$dst/$name"
            echo "  Copied: $name"
        fi
    done

    # Skills, commands, agents, plugins, themes
    for name in \
        skill skills \
        command commands \
        agent agents \
        mode modes \
        plugin plugins \
        themes
    do
        if [[ -d "$src/$name" ]]; then
            mkdir -p "$dst/$name"
            rsync -a "$src/$name/" "$dst/$name/"
            echo "  Synced: $name/"
        fi
    done

    echo "Kilo sync complete."
}

