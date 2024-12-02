# 
# PATH
#
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/games/bin:$PATH"
export PATH="$(yarn global bin):$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

source <(kubectl completion zsh)
source /usr/share/nvm/init-nvm.sh


nvm use 20
# echo "node: $(nvm which current)"
# ln -fs $(nvm which current) ~/.local/bin/node
