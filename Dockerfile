FROM kjjuno/dev:latest

COPY vimrc.vim /root/.vimrc

ENV OMNISHARP_VERSION=v1.32.1 \
    OMNISHARP_FILE=omnisharp.http-linux-x64.tar.gz

ENV OMNISHARP_URL=https://github.com/OmniSharp/omnisharp-roslyn/releases/download/$OMNISHARP_VERSION/$OMNISHARP_FILE \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true \
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Opt out of telemetry
    DOTNET_CLI_TELEMETRY_OPTOUT=true

# vim plugins and dotnet core 2.2
RUN vim +PluginInstall +qall && \
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-2.2 libuv1-dev && \
    dotnet help

# Omnisharp Server
RUN wget -q $OMNISHARP_URL && \
    mkdir -p /root/.omnisharp && \
    tar xvzf $OMNISHARP_FILE -C /root/.omnisharp && \
    rm $OMNISHARP_FILE

