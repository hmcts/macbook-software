#!/bin/bash

echo "🔧 Setting up Docker for non-admin users..."

# Detect shell type
SHELL_RC=""
if [[ "$SHELL" == "/bin/zsh" ]]; then
    SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL" == "/bin/bash" ]]; then
    SHELL_RC="$HOME/.bashrc"
else
    echo "⚠️ Unsupported shell. Please use Bash or Zsh."
    exit 1
fi

#set PATH to pick up docker installed in HOME/.docker/bin
echo "export PATH=$PATH:$HOME/.docker/bin" >> "$SHELL_RC"

# Set the DOCKER_HOST environment variable
if ! grep -q "DOCKER_HOST=unix://\$HOME/.docker/run/docker.sock" "$SHELL_RC"; then
    echo "export DOCKER_HOST=unix://\$HOME/.docker/run/docker.sock" >> "$SHELL_RC"
    echo "✅ Added DOCKER_HOST to $SHELL_RC"
else
    echo "✅ DOCKER_HOST is already set in $SHELL_RC"
fi

# Reload the shell configuration
source "$SHELL_RC"

# Create Docker socket directory if it doesn't exist
mkdir -p $HOME/.docker/run
chmod 700 $HOME/.docker

# Restart Docker Desktop to ensure the user socket is created
echo "🔄 Now Please Restart Your Docker Desktop..."
echo "...After the restart check that Docker should have created the following file..."
echo "The file is $HOME/.docker/run/docker.sock"
