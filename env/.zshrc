# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
source ~/codebase/dep/powerlevel10k/powerlevel10k.zsh-theme

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Aliases
alias v="/usr/bin/nvim"
alias vim="/usr/bin/nvim"

alias vol:up="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"
alias vol:down="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
alias vol:mute="wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
alias tab:rename="wezterm cli set-tab-title "
alias wifi:office="nmcli connection up Father\ loves\ you\ 5G"
alias wifi:room="nmcli connection up HOLY\ SPIRIT\ loves\ you"
alias wifi:living="nmcli connection up JESUS\ loves\ you\ 5G"
alias wifi:vpn="nmcli connection up zolar-vpn-access --ask"

alias grw:t="gradle test"
alias grw:tc="gradle test --continuous"
alias grw:tt="gradle test --tests "
alias grw:ttc="gradle test --continuous --tests "
alias grw:b="gradle build"
alias grw:br="gradle bootRun"
alias grw:brc="gradle bootRun --continuous"

# Inspired here: https://catalins.tech/zsh-plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use)

source $ZSH/oh-my-zsh.sh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh)"


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
