# Todo Flask App with MariaDB
Original source code from https://github.com/jakerieger/FlaskIntroduction and has been updated in https://github.com/cloudacode/FlaskIntroduction 

## Features
- Update `SQLALCHEMY_DATABASE_URI` to implement MariaDB
- Allow anywhere host='0.0.0.0'
- Build MariaDB Container

## How To Run locally(via Docker Compose)
1. If not already done, [install Docker Compose](https://docs.docker.com/compose/install/)
2. Run `docker-compose build --pull --no-cache` to build fresh images
3. Run `docker-compose up` (the logs will be displayed in the current shell)
4. Open `https://localhost:5000` in your favorite web browser
5. Run `docker-compose down --remove-orphans` to stop the containers.

## How To Run locally(via Minikube)
1. If not already done, [install Minikube](https://minikube.sigs.k8s.io/docs/start/)
2. Run `minikube start` to start minikube locally
3. Run `kubectl apply -f k8s-manifest/todo-mariadb-app.yaml` to deploy mariadb and service endpoint
4. Run `kubectl apply -f k8s-manifest/todo-flask-app.yaml` to deploy flask app and service endpoint
5. Run `kubectl get svc` in check the exposed service. you may see the `EXTERNAL-IP` is `pending` status due to minikube doesn't have extra LB. You should use the `minikube tunnel` to get the external-ip for the service. [Loadbalancer Access](https://minikube.sigs.k8s.io/docs/handbook/accessing/#loadbalancer-access)
```bash
kubectl get svc todo-app-svc
NAME           TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
todo-app-svc   LoadBalancer   10.102.161.248   <pending>     80:31289/TCP   54s
```
6. Run `minikube tunnel` in a *seperate terminal* to enable external-ip
```bash
minikube tunnel
❗  The service todo-app-svc requires privileged ports to be exposed: [80]
🔑  sudo permission will be asked for it.
🏃  Starting tunnel for service todo-app-svc.
Password:

```
7. Run `kubectl get svc todo-app-svc` in check the external-ip and it will be 
```bash
kubectl get svc todo-app-svc
NAME           TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
todo-app-svc   LoadBalancer   10.102.161.248   127.0.0.1     80:31289/TCP   5m41s
``` 
8. Open `http://127.0.0.1` in your favorite web browser and check the flask todo app
9. Run `kubectl scale --replicas=3 deployment/todo-app` to scale up the app
```
$ kubectl scale --replicas=3 deployment/todo-app
deployment.apps/todo-app scaled
$ kubectl get pods
NAME                        READY   STATUS              RESTARTS   AGE
mysql-8bb5f69f8-cs55w       1/1     Running             0          10m
todo-app-576d68cf7f-cf74w   1/1     Running             0          5s
todo-app-576d68cf7f-mskbm   1/1     Running             0          7m16s
todo-app-576d68cf7f-w8x8q   0/1     ContainerCreating   0          5s
```
10. Run `kubectl delete -f k8s-manifest/todo-flask-app.yaml` and `kubectl delete -f k8s-manifest/todo-mariadb-app.yaml` to delete resources.