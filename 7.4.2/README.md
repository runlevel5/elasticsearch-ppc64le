## Elasticsearch for Linux ppc64le

### How to build ES on Linux host?

```
$ sudo ./install_es.sh
```

### How to build docker image?

If you use Docker, please run:

```
$ docker build . --tag=es742
```

If you use buildah, please run:

```
$ buildah build-using-dockerfile . --tag=es742
```

