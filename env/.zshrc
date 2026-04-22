# 1. Powerlevel10k instant prompt (Must stay at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 2. Exports & Path Configuration
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="/opt/homebrew/bin/nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export BUN_INSTALL="$HOME/.bun"
export PATH=/Users/tomas.pavlatka/.opencode/bin:$PATH
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"

# 3. Oh My Zsh Setup
ZSH_THEME="robbyrussell" 
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search kubectl)
source $ZSH/oh-my-zsh.sh

# 4. Tool Initializations (FZF, Zoxide, NVM)
# This enables fzf for Ctrl+R (History) and Ctrl+T (Files)
source <(fzf --zsh)

# Optional: Enhanced fzf history search appearance
export FZF_CTRL_R_OPTS="--height 40% --layout=reverse --border --inline-info"

# Zoxide (Smart cd)
eval "$(zoxide init zsh)"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# 5. External Tool Integrations (Google Cloud SDK)
if [ -f '/Users/tomas.pavlatka/codebase/google-cloud-sdk/path.zsh.inc' ]; then 
  source '/Users/tomas.pavlatka/codebase/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/tomas.pavlatka/codebase/google-cloud-sdk/completion.zsh.inc' ]; then 
  source '/Users/tomas.pavlatka/codebase/google-cloud-sdk/completion.zsh.inc'
fi

# 6. Aliases
alias v="/opt/homebrew/bin/nvim"
alias vim="/opt/homebrew/bin/nvim"
alias npwd="openssl rand -base64 16"
alias npwdc="openssl rand -base64 16 | pbcopy"
alias ttest="clear && yarn test"
alias yarnf="yarn format"
alias yarnl="yarn lint"
alias gcaf="git commit -am \"formatting\""
alias gcal="git commit -am \"linting\""

setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don\'t record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don\'t record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don\'t write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# bun completions
[ -s "/Users/tomas.pavlatka/.bun/_bun" ] && source "/Users/tomas.pavlatka/.bun/_bun"

# 7. Theme Customization (Must stay at the bottom)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
