### Deploy Kind or K3d Cluster

It is your choice 2 options are available (k3d or kind).
Both of them are fine from test perspective.

#### K3d
Install binaries & spinup cluster

```
bin/k3d-install.sh
bin/k3d-setup.sh
```

![K3D](./images/k3d-spin-up.gif "K3D Setup")

Please go as follow the questions. Installation will automatically switch kubectl context to fresh one.


#### Kind 
Install binaries & setting up cluster

```
bin/kind-install.sh
bin/kind-setup.sh
```

![Kind](./images/kind-spin-up.gif "Kind Setup")