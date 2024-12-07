# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:~/go/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export OPENSSL_DIR=$(brew --prefix openssl)

# CONFIGURATOR UI
export NVM_DIR=~/.nvm
export DOCKER_HOST_IP=localhost
source $(brew --prefix nvm)/nvm.sh

export PHP_CS_FIXER_IGNORE_ENV=true
export LOCAL_CODEBASE_DIR="~/codebase/"

# avoid encoding problems
export LC_ALL=
export LANG=
export PASSWORD_STORE_DIR=~/.config/ptx-cli-pwd

# fix docker bug
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git z aws zsh-syntax-highlighting web-search zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

## alias
alias v="/opt/homebrew/bin/nvim"
alias pcl="cd /Users/tomaspavlatka/codebase/personal/ptx-cli/target/release; ./ptx-cli"
alias easypay:offer:fix-total="pcl -e production easypay offer fix-total --body"
alias db:token:easypay="export AWS_REGION=eu-central-1;npx -p @zolargmbh/ops-tools generate-rds-auth-token --db-username ep-prod-prod-ep-read-rights-user"
alias db:token:easypay-super="export AWS_REGION=eu-central-1;npx -p @zolargmbh/ops-tools generate-rds-auth-token --db-username ep-prod-produ-ep-all-rights-user"
alias db:token:zoc="export AWS_REGION=eu-central-1;npx -p @zolargmbh/ops-tools generate-rds-auth-token --db-username prod-production-zoc-zoc_readonly"
alias db:token:zoc-super="export AWS_REGION=eu-central-1;npx -p @zolargmbh/ops-tools generate-rds-auth-token --db-username prod-production-z-zoc_read_write"
alias ep:lint="nx run admin:lint --quiet"
alias ep:test="nx run admin:test --silent"
alias ep:int-test="DATABASE_URL=\"mysql://root:example@127.0.0.1:3306/easypay?schema=public\" nx run admin:integration-test --silent"
alias ep:pre-commit="ep:lint && ep:int-test && ep:test"
alias prisma:migrate-dev="DATABASE_URL=\"mysql://root:root@127.0.0.1:3306/zolar_easypay?schema=public\" npx prisma migrate dev"
alias prisma:deploy-dev="DATABASE_URL=\"mysql://root:root@127.0.0.1:3306/zolar_easypay?schema=public\" npx prisma migrate deploy"
alias prisma:format="DATABASE_URL=\"mysql://root:example@127.0.0.1:3306/easypay?schema=public\" npx prisma format "
alias kafka:group:descr="kafka-consumer-groups --bootstrap-server pkc-zpjg0.eu-central-1.aws.confluent.cloud:9092 --command-config ~/codebase/kafka/client.properties --describe"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
