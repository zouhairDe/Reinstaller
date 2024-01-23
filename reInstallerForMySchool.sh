#!/bin/bash

# Set your GitHub username and personal access token
githubUsername="zouhairDe"
githubToken="**************************************"

# Install Oh-my-zsh
zshInstaller="sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
echo "Installing Oh-my-zsh... $zshInstaller"
eval "$zshInstaller"

# Install zsh-autosuggestions
autoSuggestionsInstaller="sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/zsh-users/zsh-autosuggestions/master/install.sh)\""
echo "Installing zsh-autosuggestions... $autoSuggestionsInstaller"
eval "$autoSuggestionsInstaller"

# Edit .zshrc to add zsh-autosuggestions to plugins
zshPluginAdder="sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/' ~/.zshrc"
echo "Adding zsh-autosuggestions to .zshrc... $zshPluginAdder"
eval "$zshPluginAdder"
echo "Changes to .zshrc have been made."

# Clone Cleaner_42 repository
echo "Cloning Cleaner_42 repository..."
git clone https://github.com/ombhd/Cleaner_42.git

# Enter the cloned directory
cd Cleaner_42

# Run CleanerInstaller.sh
echo "Running CleanerInstaller.sh..."
./CleanerInstaller.sh

# Generate SSH key without prompts
echo "Generating SSH key..."
ssh-keygen -t rsa -b 4096 -C "" -f ~/.ssh/id_rsa -N ""

# Get the public key
publicKey="$(cat ~/.ssh/id_rsa.pub)"

# Add SSH key to GitHub using the GitHub API
echo "Adding SSH key to GitHub..."
curl -u "$githubUsername:$githubToken" -X POST -H "Content-Type: application/json" -d "{\"title\":\"MySSHKey\",\"key\":\"$publicKey\"}" https://api.github.com/user/keys

echo "SSH key added to your GitHub account."
echo "Script execution completed."
