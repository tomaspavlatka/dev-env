# 1. Powerlevel10k instant prompt (Must stay at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 2. Exports & Path Configuration
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="/opt/homebrew/bin/nvim"
export PATH=/Users/tomas.pavlatka/.opencode/bin:$PATH

# 3. Oh My Zsh Setup
ZSH_THEME="robbyrussell" 
plugins=(git zsh-autosuggestions zsh-syntax-highlighting) 
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
alias k="kubectl"
alias vim="/opt/homebrew/bin/nvim"
alias npwd="openssl rand -base64 16"
alias npwdc="openssl rand -base64 16 | pbcopy"
alias ttest="clear && yarn test"

# 7. Theme Customization (Must stay at the bottom)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
