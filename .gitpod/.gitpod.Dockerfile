FROM gitpod/workspace-full

RUN pyenv install 3.11 \
    && pyenv global 3.11

# Setup Ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | \
  sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
  echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | \
  sudo tee /etc/apt/sources.list.d/ngrok.list

USER gitpod

RUN sudo install-packages vim bat httpie fzf thefuck fd-find ngrok


# Setup NVM - Latest lts version
RUN bash -c 'source $HOME/.nvm/nvm.sh && nvm install --lts --default \
    && nvm use --lts'

RUN echo "source $HOME/.nvm/nvm.sh && nvm use default &>/dev/null" >> ~/.bashrc.d/51-nvm-fix

ARG NODE_MODULES="typescript prettier"
RUN bash -c 'source $HOME/.nvm/nvm.sh && npm install -g ${NODE_MODULES}' 2>&1

# Setup ZSH
ENV SHELL=/usr/bin/zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
