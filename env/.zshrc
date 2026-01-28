# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export EDITOR="/opt/homebrew/bin/nvim"
ZSH_THEME="robbyrussell"

# Aliases
alias v="/opt/homebrew/bin/nvim"
alias k="kubectl"
alias vim="/opt/homebrew/bin/nvim"
alias npwd="openssl rand -base64 16"
alias npwdc="openssl rand -base64 16 | pbcopy"
alias ttest="clear && yarn test"

# Inspired here: https://catalins.tech/zsh-plugins/
plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/Users/tomas.pavlatka/.opencode/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tomas.pavlatka/codebase/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tomas.pavlatka/codebase/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tomas.pavlatka/codebase/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tomas.pavlatka/codebase/google-cloud-sdk/completion.zsh.inc'; fi
