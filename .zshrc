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

# ros2 humble environment with zsh tab completion
sros() {
    # deactivate every active conda env, including base
    while (( ${CONDA_SHLVL:-0} > 0 )); do
        conda deactivate || break
    done
    source /opt/ros/humble/setup.zsh
    [[ -f ~/ros2_ws/install/setup.zsh ]] && source ~/ros2_ws/install/setup.zsh
    # enable argcomplete for ros2 and colcon
    autoload -U +X bashcompinit && bashcompinit
    eval "$(register-python-argcomplete3 ros2)"
    eval "$(register-python-argcomplete3 colcon)"
}

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


# ==========================================
# Sync All Agents
# ==========================================

sync-agents() {
    local failed=0

    echo "================================"
    echo " Syncing Agent Configurations"
    echo "================================"
    echo

    sync-codex-edu || failed=1

    echo

    sync-kilo-edu || failed=1

    echo

    if (( failed == 0 )); then
        echo "All agent configurations synchronized."
    else
        echo "One or more agent syncs failed."
    fi

    return "$failed"
}

# ==========================================
# Kilo Session Handoff
# Personal <-> Edu
# ==========================================

_kilo-handoff() (
    local from="$1"
    local to="$2"
    local id="$3"
    local tmpdir

    if [[ -z "$id" ]]; then
        echo "Usage: kilo-{personal2edu|edu2personal} SESSION_ID"
        return 2
    fi

    # Private temporary directory
    umask 077
    tmpdir=$(mktemp -d "${TMPDIR:-/tmp}/kilo-handoff.XXXXXXXX") || return 1
    trap 'rm -rf -- "$tmpdir"' EXIT

    echo "Handoff: $from -> $to"
    echo "Session: $id"

    # Export latest history from source
    if ! "$from" export "$id" > "$tmpdir/source.json"; then
        echo "ERROR: Session export failed."
        return 1
    fi

    # Export destination's existing copy, if present
    if ! "$to" export "$id" > "$tmpdir/dest.json" 2>/dev/null; then
        rm -f "$tmpdir/dest.json"
    fi

    # Validate session ID, project, and history continuity
    python3 - "$id" "$tmpdir/source.json" "$tmpdir/dest.json" <<'PY'
import json
import os
import sys
from pathlib import Path

sid, source_file, dest_file = sys.argv[1:]

try:
    with open(source_file) as f:
        source = json.load(f)

    if source["info"]["id"] != sid:
        raise ValueError("Source session ID mismatch")

    # Kilo imports into the current working directory
    directory = source["info"].get("directory")
    if directory and os.path.realpath(directory) != os.path.realpath(os.getcwd()):
        raise ValueError(
            f"Run handoff from the session's project directory:\n{directory}"
        )

    if Path(dest_file).exists():
        with open(dest_file) as f:
            dest = json.load(f)

        if dest["info"]["id"] != sid:
            raise ValueError("Destination session ID mismatch")

        source_ids = {m["info"]["id"] for m in source["messages"]}
        dest_ids = {m["info"]["id"] for m in dest["messages"]}

        missing = dest_ids - source_ids

        if missing:
            raise ValueError(
                f"Destination has {len(missing)} messages "
                "not present in source.\n"
                "Possible divergence or wrong handoff direction."
            )

    print("History continuity verified.")

except (OSError, ValueError, KeyError, TypeError) as e:
    print(f"ERROR: {e}", file=sys.stderr)
    sys.exit(1)
PY

    if [[ $? -ne 0 ]]; then
        echo "Handoff aborted. No destination changes made."
        return 1
    fi

    # Import preserves session ID and adds missing messages
    if ! "$to" import "$tmpdir/source.json"; then
        echo "ERROR: Session import failed."
        return 1
    fi

    echo "Handoff completed."
    echo "Opening session with $to..."

    # Remove temporary transcript before starting interactive Kilo
    rm -rf -- "$tmpdir"

    "$to" --session "$id"
)

# Personal -> Edu
kilo-personal2edu() {
    _kilo-handoff kilo-personal kilo-edu "$1"
}

# Edu -> Personal
kilo-edu2personal() {
    _kilo-handoff kilo-edu kilo-personal "$1"
}

