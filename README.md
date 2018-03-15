
# Docker GoTTY


## Build it

```bash
$ ./build.sh
```

```bash
$ docker images
REPOSITORY                                               TAG                 IMAGE ID            CREATED             SIZE
dieterreuter/gotty                                       latest              eff77035b86d        12 minutes ago      19.3MB
```


## Deploy in Docker


## Deploy in Kubernetes (or k8s in Docker4Mac)

Deploy Pod and use a NodePort service
```bash
$ kubectl apply -f kube-gotty.yml
```

Determine the TCP port
```bash
$ kubectl get svc
NAME             TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
kube-gotty-svc   NodePort    10.97.21.53   <none>        8080:31725/TCP   7s
```

Open web browser
```bash
$ open http://localhost:31725
```
