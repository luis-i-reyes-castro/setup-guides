# =========================================================================================
# COSMETIC TWEAKS

# Directory colors
eval "$(dircolors "$HOME/.dircolors")"

# Git : Setup PS1 Colors
blue="\[\033[0;34m\]"
cyan="\[\033[0;36m\]"
green="\[\033[0;32m\]"
purple="\[\033[0;35m\]"
yellow="\[\033[93m\]"
reset="\[\033[0m\]"

# Git: Setup PS1
# '\u' adds the name of the current user to the prompt
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
export PS1="$cyan\u$yellow\$(__git_repo)$green\$(__prompt_dir) $ $reset"

# Resolve symbolic links
set -o physical

# Tab size (8 -> 4)
tabs -4

# -----------------------------------------------------------------------------------------
# DEVELOPMENT ENVIRONMENTS AND ALIASES

# Python environment
PYTHON_ENV="$HOME/pe/bin/activate"
if [[ -f "$PYTHON_ENV" ]]; then
    source "$PYTHON_ENV"
fi

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
if [[ -d "$NVM_DIR" ]]; then
    [ -s "$NVM_DIR/nvm.sh" ]          && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# 3D Slicer
SLICER_VERSION="5.12.3"
SLICER_APP="$HOME/apps/Slicer-${SLICER_VERSION}-linux-amd64/Slicer"
if [[ -f "$SLICER_APP" ]]; then
    alias slicer="$SLICER_APP"
fi
