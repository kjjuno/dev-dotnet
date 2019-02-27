FROM kjjuno/dev-mono:latest

# dotnet core 2.2
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y dotnet-sdk-2.2 libuv1-dev

ADD https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.32.1/omnisharp.http-linux-x64.tar.gz .
RUN mkdir -p /root/.omnisharp
RUN tar xvzf omnisharp.http-linux-x64.tar.gz -C /root/.omnisharp
#ADD omnisharp.http-linux-x64.tar.gz /root/.omnisharp

COPY vimrc.vim /root/.vimrc
RUN vim +PluginInstall +qall
