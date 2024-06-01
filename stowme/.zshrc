# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

alias aws2=/usr/local/bin/aws
alias src='source ~/.zshrc'

eval "$(starship init zsh)"
eval "$(pyenv init --path)" > /dev/null

check_git_config() {
    if git config --global user.name > /dev/null; then
        echo -e "\e[1;32m---------------------------------\e[0m"
        echo -e "\e[1;32m|   Git username is set.       |\e[0m"
        echo -e "\e[1;32m---------------------------------\e[0m"
    else
        echo -e "\e[1;31m-------------------------------------\e[0m"
        echo -e "\e[1;31m|   Git username is not set.       |\e[0m"
        echo -e "\e[1;31m|   Running Ansible playbook!   |\e[0m"
        echo -e "\e[1;31m-------------------------------------\e[0m"
        ansible-playbook $HOME/dotfiles/ansible/playbooks/git.yaml
    fi
}


cc() {
    cd && cd "$(fdfind -d 2 /workspaces /config/workspaces ~ | cut -c 1- | fzf )"
}

envrc() {
    cp $HOME/configuration/envrc.base ./.envrc
}

activate-venv () {
    export ENV_DIR=$(ls /opt/python-environments | fzf)
    source /opt/python-environments/$ENV_DIR/bin/activate
}

new-venv () {
    # Ask user for name of venv
    echo "Enter the name of the new virtual environment:"
    read venv_name

    # Create new venv
    python3 -m venv /opt/python-environments/$venv_name
}


hello() {
    # Define colors
    red=$(tput setaf 1)
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    cyan=$(tput setaf 6; tput bold)  # Cyan color; bold text
    reset=$(tput sgr0)

    # Print banner
    echo "${cyan}==================== Dev Status ====================${reset}"
    echo
    echo "${yellow}===================================================${reset}"
    echo

    # Git username and email
    echo "${yellow}Git Config:${reset}"
    echo "${green}Username: $(git config --get user.name)${reset}"
    echo "${green}Email: $(git config --get user.email)${reset}"
    echo
    echo "${green}===================================================${reset}"
    echo
    echo "Type ${cyan}setup-code${reset} to install some useful code-extensions"
    echo
    echo "Type ${cyan}get-started${reset} for simple guide on using this devcontainer"
    echo
    echo "${yellow}===================================================${reset}"
}

setup-code() {
    ansible-playbook $HOME/dotfiles/ansible/playbooks/code-extensions.yaml
}


get-started() {
    # Define colors
    red=$(tput setaf 1)
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    cyan=$(tput setaf 6; tput bold)  # Cyan color; bold text
    reset=$(tput sgr0)

    # Print banner
    echo "${cyan}==================== RA Devcontainer ====================${reset}"
    echo
    echo "${yellow}===================================================${reset}"
    echo "0. To install some standard extensions in VS Code, type ${cyan}ra-setup-code${reset}"
    echo "1. Clone projects into /workspaces/"
    echo "2. Open a terminal and type ${cyan}cc${reset} to navigate to your project"
    echo "3. Setup Python environment with 'new-venv' and activate it with 'activate-venv'"
    echo "4. To configure VS Code to use the right virtual environment, open the Command Palette '(Ctrl+Shift+P)' and type 'Python: Select Interpreter',"
    echo "   then input the path to the Python venv you just created. 'new-venv' puts Python venvs in '/opt/python-environments',"
    echo "   so if you named your venv 'foo', then the path to input would be '/opt/python-environments/foo/bin/python'."
    echo "   Notice the '/bin/python' at the end."
}

hello
