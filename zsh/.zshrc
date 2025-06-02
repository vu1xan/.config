export PATH="/usr/local/bin:$PATH"
export PATH="/Users/vulcan/Library/Python/3.9/bin:$PATH"

# Load completions
autoload -Uz compinit && compinit

# Keybindings
# bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# Aliases
alias l='ls -lha --color'
# alias vim='nvim'
alias c='clear'
alias python='python3'
alias pip='pip3'

alias /='cd /'
alias ..='cd ..'
alias p='cd ~/projects'
alias pp='cd ~/papers'
alias ds='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias d='cd ~/Documents'
alias icloud='cd /Users/vulcan/Library/Mobile\ Documents/com~apple~CloudDocs'

# Enable or Disable .DS_Store on network stores
alias ntwrkdsstrdisable='defaults write com.apple.desktopservices DSDontWriteNetworkStores true'
alias ntwrkdsstrenable='defaults write com.apple.desktopservices DSDontWriteNetworkStores false'

# Enable or Disable .DS_Store on removable drives
alias rmvdsstrdisable='defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true'
alias rmvdsstrenable='defaults write com.apple.desktopservices DSDontWriteUSBStores -bool false'
