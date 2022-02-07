# Source controller
There are 3 types of repository:

- [X] git
- [X] helm
- [X] bucket

It is recommended to use only 2 of them cause last one bucket may
turn out to havy.

## Adding existing git repository
```
flux create source git app01 \
    --url=https://github.com/devopsapp84/sample-apps \
    --branch=main
```

## Adding existing helmchart repository
```
flux create source helm apprepo \
--url=https://devopsapp84.github.io/flux2-capabilities/ \
--interval=10m \
```

In both cases declarative approach requires export definition and store them on github itself. 
Must be stored in flux root directory for instance clusters/flux-poc.
<br/>
For have it exported add options `--export > <filename>.yaml` since filename should
indicate proper name for example: git-repository-app01 or for helm helm-repository-apps.

## Adding bucket - TBD
