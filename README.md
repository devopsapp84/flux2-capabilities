## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

```
  helm repo add apprepo https://devopsapp84.github.io/flux2-capabilities-clean
```

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages. You can then run `helm search repo
test` to see the charts.

To install the app01 chart:
```
    helm install app01 apprepo/app01
```

To uninstall the chart:
```
    helm delete app01
```

To install the app02 chart:
```
    helm install app02 apprepo/app02
```

To uninstall the chart:
```
    helm delete app02
```
