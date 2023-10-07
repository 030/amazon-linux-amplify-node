FROM amazonlinux:2023

ENV NODE_VERSION 20.8.0
ENV NVM_DIR /usr/local/nvm
ENV NODE_HOME ${NVM_DIR}/versions/node/v${NODE_VERSION}
ENV NODE_PATH ${NODE_HOME}/lib/node_modules
ENV PATH ${NODE_HOME}/bin:$PATH

RUN dnf update -y && \
    dnf upgrade -y && \
    dnf install -y \
        git \
        gzip \
        tar \
        unzip && \
    dnf remove node* -y && \
    mkdir -p ${NVM_DIR} && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.2/install.sh | bash && \
    /bin/bash -c "source ${NVM_DIR}/nvm.sh && nvm install ${NODE_VERSION} && nvm use --delete-prefix ${NODE_VERSION}" && \
    rm -rf /var/cache/dnf && \
    dnf clean all && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install
