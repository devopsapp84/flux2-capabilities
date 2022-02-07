### Securing secrets using kubeseal from bitnami
Securing GitOps is most important topic. base64 is not encription this is only encoding! 
Everyone can use it bases64 -d and encode those secrets!

```
flux create source helm sealed-secrets \
--interval=1h \
--url=https://bitnami-labs.github.io/sealed-secrets
```

```
flux create helmrelease sealed-secrets \
--interval=1h \
--release-name=sealed-secrets-controller \
--target-namespace=flux-system \
--source=HelmRepository/sealed-secrets \
--chart=sealed-secrets \
--chart-version=">=1.15.0-0" \
--crds=CreateReplace --export
```