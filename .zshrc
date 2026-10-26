# =========================================================================================
# COSMETIC TWEAKS

# Directory colors
export CLICOLOR=1

# Git: Setup prompt
# '%n' adds the name of the current user to the prompt
# '$(__git_repo)' adds the repository name
# '$(__prompt_dir)' adds the current directory unless it is the repository root
__git_repo() {
    local root state
    root=$(git rev-parse --show-toplevel 2>/dev/null) || return
    git diff --no-ext-diff --quiet || state='*'
    git diff --no-ext-diff --cached --quiet || state+='+'
    printf ' (%s%s)' "${root##*/}" "$state"
}
__prompt_dir() {
    local dir root
    dir=$(pwd -P)
    root=$(git rev-parse --show-toplevel 2>/dev/null)
    [[ -n "$root" && "$dir" == "$root" ]] && return

    case "$dir" in
        "$HOME") dir='~' ;;
        /)       dir='/' ;;
        *)       dir=${dir##*/} ;;
    esac
    printf ' %s' "$dir"
}
setopt prompt_subst
PROMPT='%F{cyan}%n%F{yellow}$(__git_repo)%F{green}$(__prompt_dir) $ %f'

# Resolve symbolic links
setopt chase_links

# Tab size (8 -> 4)
tabs -4

# -----------------------------------------------------------------------------------------
# DEVELOPMENT ENVIRONMENTS AND ALIASES

# Python environment
PYTHON_ENV="$HOME/pe/bin/activate"
if [[ -f "$PYTHON_ENV" ]]; then
    source "$PYTHON_ENV"
fi

# 3D Slicer
alias slicer='open -a Slicer'

# -----------------------------------------------------------------------------------------
# ZSH COMPLETION

# Homebrew completions
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
# Cache speeds things up on repeated sessions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# Friendly matching & UI
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|=*' 'l:|=*'
zstyle ':completion:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
compinit
