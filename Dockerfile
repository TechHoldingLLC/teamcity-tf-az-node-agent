FROM jetbrains/teamcity-minimal-agent:latest
USER root

RUN apt-get update
RUN apt-get install -y build-essential git jq

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

USER buildagent

RUN git clone -b v1.0.2 --depth 1 https://github.com/tfutils/tfenv.git /home/buildagent/.tfenv
RUN git clone -b v0.0.3 --depth 1 https://github.com/cunymatthieu/tgenv.git /home/buildagent/.tgenv
RUN chmod -R 755 /home/buildagent/.tfenv/bin/terraform
RUN chmod -R 755 /home/buildagent/.tgenv/bin/terragrunt

USER root

RUN ln -s /home/buildagent/.tfenv/bin/tfenv /bin/tfenv
RUN ln -s /home/buildagent/.tfenv/bin/terraform /bin/terraform
RUN ln -s /home/buildagent/.tgenv/bin/tgenv /bin/tgenv
RUN ln -s /home/buildagent/.tgenv/bin/terragrunt /bin/terragrunt

USER buildagent

RUN echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> /home/buildagent/.bashrc
RUN echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> /home/buildagent/.bashrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
