# TeamCity Minimal Agent with Terraform, Terragrunt, Azure CLI, Node

This image is based of the teamcity minimal agent, with a few extra elements for flavor:

- tfenv to dynamically manage terraform required version
- tgenv to dynamically manage terragrunt required version
- node
- azure cli
- make
- jq

## How to run

```sh
docker run -d \
 -e SERVER_URL="<your-teamcity-server:port>" \
 -e AGENT_NAME="<the-agent-cute-name>"  \
 -v <where-you-want/the-volume/on-the-host>:/data/teamcity_agent/conf  \
 --name="<name of the container>"  \
 techholdingllc/teamcity-tf-az-node-agent<:optionally-the-version>
```
