ARG VARIANT=3.11
ARG USERNAME=vscode

FROM mcr.microsoft.com/devcontainers/python:${VARIANT}

# Setup Ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | \
  sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
  echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | \
  sudo tee /etc/apt/sources.list.d/ngrok.list

# Install APT packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get install -y vim python3-full bat httpie fzf thefuck fd-find ngrok \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="lts/*"
ARG NODE_MODULES="typescript aws-cdk prettier cdk-dia prettier aws-cdk @aws-lambda-powertools/tracer @aws-lambda-powertools/metrics @aws-lambda-powertools/logger joplin"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g ${NODE_MODULES}" 2>&1


# Store vscode extensions between builds
ARG USERNAME=vscode
RUN mkdir -p /home/$USERNAME/.vscode-server/extensions \
  && chown -R $USERNAME /home/$USERNAME/.vscode-server

# Install pyenv
RUN su vscode -c "curl https://pyenv.run | bash"
RUN su vscode -c "pip install -r requirements.txt"
