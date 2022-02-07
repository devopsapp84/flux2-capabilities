### FluxCD

#### Install tool
Before you start using flux command line first install it.

```
bin/flux-install.sh
```

This is wrapper script based on [documentation](https://fluxcd.io/docs/installation/)

#### Bootstrap 
Create Personal Access Token on Github (Signing up as -> Developer settings -> Personal access tokens -> Generate new token)
following this [instruction](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) 

Be aware set only minimum level permission!

[Personal token](./images/personal-token.png)


Add GITHUB_USER and GITHUB_TOKEN variables into .bash_profile

```
cat << EOF >> ~/.bash_profile
export GITHUB_USER=<redacted>
export GITHUB_TOKEN=<redacted>
EOF
```

Bootstrapping Flux

```
flux bootstrap github --owner=$GITHUB_USER \
--repository=flux2-capabilities \
--branch=main \
--path=./clusters/flux-poc \
--owner=devopsapp84 \
--log-level=debug \
--network-policy=false \
--prune=true
```

If no specified components then all controlers will be installed. 
<br/>
<br/>
We bootstrapped flux with prune set to true since deletion files on github will cause reconcil deletion objects on kubernetes environment (quite handy).


![Bootstrapping](./images/flux-bootstrap.gif "Flux install")


Repository overview:

![Repo](./images/flux-infra-overview.gif "Repository overview")

List flux objects:

![status](./images/check-flux-status.gif "Flux status")