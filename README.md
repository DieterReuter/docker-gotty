
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

Run GoTTY container
```bash
$ docker run -d --name=gotty -p 8080:8080 dieterreuter/gotty
71653819daec2c81d6eafbf9a000c5dec744b9fadd88ee98050de9933859fcf0
```

Check logs
```bash
$ docker logs gotty
2018/03/15 19:49:52 Permitting clients to write input to the PTY.
2018/03/15 19:49:52 Server is starting with command: /bin/ash
2018/03/15 19:49:52 URL: http://127.0.0.1:8080/
2018/03/15 19:49:52 URL: http://172.17.0.2:8080/
```

Open web browser
```bash
$ open http://localhost:8080
```


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
