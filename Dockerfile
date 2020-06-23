FROM jetbrains/teamcity-minimal-agent:latest
USER root

RUN apt-get update
RUN apt-get install -y build-essential git jq

RUN git clone -b v1.0.2 --depth 1 https://github.com/tfutils/tfenv.git /home/buildagent/.tfenv
RUN git clone -b v0.0.3 --depth 1 https://github.com/cunymatthieu/tgenv.git /home/buildagent/.tgenv
RUN chmod 755 /home/buildagent/.tfenv/bin/terraform
RUN chmod 755 /home/buildagent/.tgenv/bin/terragrunt

RUN echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> /home/buildagent/.bashrc
RUN echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> /home/buildagent/.bashrc


RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> /home/buildagent/.bashrc 
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> /home/buildagent/.bashrc

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

USER buildagent
