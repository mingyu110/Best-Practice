## Custom-Scheduler配置部署使用参考

### 一. Kubernetes版本 : v1.18.6
```
1. 拉取k8s源码：
　 git clone https://github.com/kubernetes/kubernetes.git
2. 切换分支：
　 git branch realse-1.18
3. 下载k8s依赖：
   go mod tidy
   go mod download
4. 替换当前工程的go.mod引用k8s的路径
　 如：k8s.io/api => /home/dev/code/go/src/github.com/kubernetes/staging/src/k8s.io/api
　 后面的/home/dev/code/go/src/github.com/kubernetes就是需要替换的内容，也就是刚才克隆的k8s地址．
```

### 二. 构建镜像
假设使用DockerHub镜像仓库
```
# 构建 Docker 镜像
docker build -t your-dockerhub-username/custom-scheduler:latest .

# 登录 Docker Hub
docker login

# 推送 Docker 镜像
docker push your-dockerhub-username/custom-scheduler:latest

```
### 三. 本地调试
```
启动需要加参数：
--config=conf/scheduler-config.yaml
--master=http://127.0.0.1:8080 ->api-server的地址
--v=3

配置文件在conf里面
```

### 四. 自定义调度器部署
- 具备集群访问管理权限
- 修改Kubernetes集群的/etc/kubernetes/scheduler-config.yaml，配置文件为测试通过的/conf目录下的文件
```
kubectl apply -f deploy/clusterrole.yaml
kubectl apply -f deploy/serviceaccount.yaml -n kube-system
kubectl apply -f deploy/configmap.yaml
kubectl apply -f deploy/scheduler-deployment.yaml
```
### 五. 使用自定义调度器
```
需要在pod模板指定调度器名称：
schedulerName: custom-scheduler
```