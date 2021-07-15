

```bash
aws lightsail create-container-service --service-name devops-flask-service --power small --scale 1
```

```bash
aws lightsail push-container-image --service-name devops-flask-service --label flask-container --image cloudacode/devops-flask:v1.0.9
```

```bash
aws lightsail create-container-service-deployment --service-name devops-flask-service --containers file://containers.json --public-endpoint file://public-endpoint.json
```

```bash
aws lightsail get-container-services --service-name devops-flask-service
```

https://lightsail.aws.amazon.com/ls/webapp/ap-northeast-2/container-services/devops-flask-service/deployments

```bash
aws lightsail delete-container-service --service-name devops-flask-service
```