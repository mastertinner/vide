FROM alpine:latest

ENV FZF_DEFAULT_COMMAND='rg --smart-case --files --no-ignore --hidden --follow \
  --glob "!.DS_Store" \
  --glob "!.git/*" \
  --glob "!vendor/*" \
  --glob "!node_modules/*" \
  --glob "!.terraform/*" \
  --glob "!bin/*" \
  --glob "!build/*" \
  --glob "!coverage/*" \
  --glob "!dist/*" \
  --glob "!target/*"'
ENV PATH="/root/.cargo/bin:$PATH"
ENV PATH="/root/go/bin:$PATH"

WORKDIR /root
RUN apk add --no-cache \
  bash \
  curl \
  fzf \
  git \
  go \
  jq \
  make \
  neovim \
  nodejs \
  nodejs-npm \
  python3-dev \
  shellcheck \
  wget
RUN curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep browser_download_url | grep x86_64-unknown-linux-musl | cut -d '"' -f 4 | wget -qi - \
  && tar -xvzf *x86_64-unknown-linux-musl.tar.gz \
  && cd ripgrep* \
  && cp rg /usr/bin \
  && cd .. \
  && rm -rf ripgrep* \
  && curl https://sh.rustup.rs -sSf | sh -s -- -y \
  && rustup component add rls rust-analysis rust-src \
  && mkdir -p .config/nvim \
  && curl https://raw.githubusercontent.com/mastertinner/dotfiles/master/nvim/.config/nvim/init.vim -o .config/nvim/init.vim \
  && curl https://raw.githubusercontent.com/mastertinner/dotfiles/master/nvim/.config/nvim/plugins.vim -o .config/nvim/plugins.vim \
  && python3 -m pip install --user --upgrade pynvim \
  && npm install -g neovim prettier \
  && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  && nvim --headless -c 'silent PlugInstall | qa' \
  && nvim --headless -c 'UpdateRemotePlugins | qa' \
  && apk del --purge \
  curl \
  jq \
  make \
  nodejs-npm \
  wget

WORKDIR /src
ENTRYPOINT ["nvim"]
