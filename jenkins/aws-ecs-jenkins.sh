## Handson materials by cloudacode.com
#!/bin/bash

##### Constants
REGION=ap-northeast-2
REPOSITORY_NAME=<YOUR_REPO_NAME>
CLUSTER=<YOUR_ECS_CLUSTER_NAME>
SERVICE_NAME=<YOUR_ECS_SERVICE_NAME>
TASKDEFINITION_NAME=<YOUR_ECS_TASKDEFINITION_NAME>

##### Store value as a variables
#repositoryUri
REPOSITORY_URI=`aws ecr describe-repositories --repository-names ${REPOSITORY_NAME} --region ${REGION} | jq .repositories[].repositoryUri | tr -d '"'`
#containerName
CONTAINER_NAME=`aws ecs describe-services --services ${SERVICE_NAME} --cluster ${CLUSTER} --region ${REGION} | jq .services[].loadBalancers[].containerName | tr -d '"'`
#family
FAMILY_NAME=`aws ecs describe-task-definition --task-definition ${TASKDEFINITION_NAME} --region ${REGION} | jq .taskDefinition.family | tr -d '"'`
#redis endpoint
REDIS_ENDPOINT=`aws ecs describe-task-definition --task-definition ${TASKDEFINITION_NAME} --region ${REGION} | jq '.taskDefinition.containerDefinitions[].environment | select( any (.name == "REDIS_URL") )[].value' | tr -d '"'`
#ports
CONTAINER_PORT=`aws ecs describe-task-definition --task-definition ${TASKDEFINITION_NAME} --region ${REGION} | jq .taskDefinition.containerDefinitions[].portMappings[].containerPort`
HOST_PORT=`aws ecs describe-task-definition --task-definition ${TASKDEFINITION_NAME} --region ${REGION} | jq .taskDefinition.containerDefinitions[].portMappings[].hostPort`
#log configuration
LOGS_GROUP=`aws ecs describe-task-definition --task-definition ${TASKDEFINITION_NAME} --region ${REGION} | jq '.taskDefinition.containerDefinitions[].logConfiguration.options."awslogs-group"' | tr -d '"'`

##### Replace task definitions file(taskdef.json)
#Replace the build number and respository URI placeholders with the constants above
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" -e "s;%REPOSITORY_URI%;${REPOSITORY_URI};g" -e "s;%FAMILY_NAME%;${FAMILY_NAME};g" -e "s;%CONTAINER_NAME%;${CONTAINER_NAME};g" -e "s;%REDIS_ENDPOINT%;${REDIS_ENDPOINT};g" -e "s;%CONTAINER_PORT%;${CONTAINER_PORT};g" -e "s;%HOST_PORT%;${HOST_PORT};g" -e "s;%LOGS_GROUP%;${LOGS_GROUP};g" -e "s;%LOGS_REGION%;${REGION};g" taskdef.json > ${TASKDEFINITION_NAME}-v_${BUILD_NUMBER}.json

##### Register the task definition in the repository
aws ecs register-task-definition --family ${FAMILY_NAME} --cli-input-json file://${WORKSPACE}/${TASKDEFINITION_NAME}-v_${BUILD_NUMBER}.json --region ${REGION}
SERVICES=`aws ecs describe-services --services ${SERVICE_NAME} --cluster ${CLUSTER} --region ${REGION} | jq .failures[]`

##### Get latest revision
REVISION=`aws ecs describe-task-definition --task-definition ${TASKDEFINITION_NAME} --region ${REGION} | jq .taskDefinition.revision`

##### Create or update service
if [ "$SERVICES" == "" ]; then
  echo "entered existing service"
  DESIRED_COUNT=`aws ecs describe-services --services ${SERVICE_NAME} --cluster ${CLUSTER} --region ${REGION} | jq .services[].desiredCount`
  if [ ${DESIRED_COUNT} = "0" ]; then
    DESIRED_COUNT="1"
  fi
  aws ecs update-service --cluster ${CLUSTER} --region ${REGION} --service ${SERVICE_NAME} --task-definition ${TASKDEFINITION_NAME}:${REVISION} --desired-count ${DESIRED_COUNT}
else
  echo "entered new service"
  aws ecs create-service --service-name ${SERVICE_NAME} --desired-count 1 --task-definition ${FAMILY_NAME} --cluster ${CLUSTER} --region ${REGION}
fi
