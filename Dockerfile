FROM --platform=amd64 debian:bookworm-slim

#GENERAL
ENV NVM_DIR=/usr/local/nvm
RUN apt update && apt install -y git bash curl unzip wget nano jq python3 python-is-python3 python3-pip python3-venv
SHELL ["/bin/bash", "-c"]

# Set up nvm
RUN mkdir -p $NVM_DIR
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN echo "source ${NVM_DIR}/nvm.sh" >> /root/.bashrc

#SPECIFIC
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN . "$HOME/.cargo/env"

RUN curl -sfL https://github.com/rust-lang/rust-analyzer/releases/download/2024-03-25/rust-analyzer-x86_64-unknown-linux-gnu.gz --output rust-analyzer.gz && \
  gunzip rust-analyzer.gz && \
  mv rust-analyzer /root/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer \
  && chmod +x  /root/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer

COPY ./package.json /scripts/
COPY ./scip.ts /scripts/
COPY ./testscript.ts /scripts/
RUN chmod +x /scripts/testscript.ts

RUN /bin/bash -c "source ${NVM_DIR}/nvm.sh && \
    nvm install 20  && \
    nvm alias default 20 && \
    npm install -g yarn && \
    npm install -g tsx && \
    nvm use default \
    && npm install -g @sourcegraph/scip-python \
    && cd /scripts \
    && npm install"

COPY ./example_working.sh /scripts/
RUN chmod +x /scripts/example_working.sh

COPY ./example_not_working.sh /scripts/
RUN chmod +x /scripts/example_not_working.sh