# antigen 配置
```zsh
# Load oh-my-zsh library.
antigen use oh-my-zsh
# Load bundles from the default repo (oh-my-zsh).
antigen bundle git
antigen bundle z
antigen bundle lein
antigen bundle extract
antigen bundle command-not-found
antigen bundle docker

# Load bundles from external repos.
antigen bundle lukechilds/zsh-nvm 
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle wbingli/zsh-wakatime
# Select theme.
antigen theme denysdovhan/spaceship-prompt
# Tell Antigen that you're done.
antigen apply

SPACESHIP_TIME_SHOW=true
SPACESHIP_USER_SHOW="always"
SPACESHIP_USER_COLOR="212"
```

[[docker]]
