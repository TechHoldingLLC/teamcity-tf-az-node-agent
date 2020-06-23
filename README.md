# TeamCity Minimal Agent with Terraform, Terragrunt, Azure CLI, NVM

This image is based of the teamcity minimal agent, with a few extra elements for flavor:

- tfenv to dynamically manage terraform required version
- tgenv to dynamically manage terragrunt required version
- nvm to dynamically manage node required version
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

## To get nvm working correctly

TeamCity has a tendency of not caring at all about `.bashrc` or any profile conf file from the system.
So, as long as the tools are installed globally, it's fine, but nvm can't do that.

So you need to source `/home/buildagent/.nvm/nvm.sh` in every steps that need to use `nvm`, `node`, or `npm`

```kts
script {
    name = "NODE version"
    scriptContent = """
        . /home/buildagent/.nvm/nvm.sh
        nvm install
        nvm use
    """.trimIndent()
}
script {
    name = "NPM install"
    scriptContent = """
        . /home/buildagent/.nvm/nvm.sh
        npm ci
    """.trimIndent()
}
```
