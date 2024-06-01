# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

alias aws2=/usr/local/bin/aws
alias src='source ~/.zshrc'

eval "$(starship init zsh)"
eval "$(pyenv init --path)" > /dev/null

eval "$(direnv hook zsh)"
# gitignore
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

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
    echo "0. To install some standard extensions in VS Code, type ${cyan}setup-code${reset}"
    echo "1. Clone projects into /workspaces/"
    echo "2. Open a terminal and type ${cyan}cc${reset} to navigate to your project"
    echo "3. Setup Python environment with 'new-venv' and activate it with 'activate-venv'"
    echo "4. To configure VS Code to use the right virtual environment, open the Command Palette '(Ctrl+Shift+P)' and type 'Python: Select Interpreter',"
    echo "   then input the path to the Python venv you just created. 'new-venv' puts Python venvs in '/opt/python-environments',"
    echo "   so if you named your venv 'foo', then the path to input would be '/opt/python-environments/foo/bin/python'."
    echo "   Notice the '/bin/python' at the end."
}

hello
