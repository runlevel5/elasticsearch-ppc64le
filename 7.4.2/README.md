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

### How to run ES OCI image?

```
$ docker run --rm -d es742
```

if you want to persist the data, you can bind the data volume:

```
$ mkdir es_data
$ docker run --rm -v ./es_data:/usr/share/elasticsearch/data es742
```

if you run into Access Denied error, you might be running SELinux, you could fix it with:

```
$ docker run --rm -v ./es_data:/usr/share/elasticsearch/data:Z es742
```
