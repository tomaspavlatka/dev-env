# Read by every zsh, interactive or not. .zshrc - which holds the nvm hook - is
# sourced only by interactive shells, so Neovim's :!, a lazy.nvim build or any
# plain script gets no nvm node. A project pinning "packageManager": "yarn@4"
# then falls through to whatever yarn is on the system PATH and aborts.
#
# Puts nvm's default version on PATH directly rather than sourcing nvm.sh, which
# costs a few hundred ms on every shell. `nvm use` still works: .zshrc loads the
# full nvm on top of this.
#
# Login shells run /usr/libexec/path_helper (via /etc/zprofile) after this file
# and it demotes the entry below /opt/homebrew/bin - harmless, because .zshrc's
# nvm.sh prepends the same directory again later.
export NVM_DIR="$HOME/.nvm"

if [[ -r $NVM_DIR/alias/default ]]; then
    # The alias holds a loose version ("24.14"), not a directory name ("v24.14.1").
    _nvm_bin=($NVM_DIR/versions/node/v${${(f)"$(<$NVM_DIR/alias/default)"}#v}*/bin(N/n))
    (( $#_nvm_bin )) && export PATH="${_nvm_bin[-1]}:$PATH"
    unset _nvm_bin
fi
