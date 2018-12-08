#!/bin/bash

while [[ $# -gt 0 ]] ; do
    key="$1"
    case $key in
        --name)
        NAME="$2"
        shift # past argument
        shift # past value
        ;;
        --param-key)
        PARAM_KEY="$2"
        shift # past argument
        shift # past value
        ;;
        --tag)
        TAG="$2"
        shift # past argument
        shift # past value
        ;;
    esac
done

if [ -z ${NAME} ] ; then
    NAME="b4cs-build"
fi

if [ -z ${TAG} ] ; then
    TAG="latest"
fi

if [ -z ${PARAM_KEY} ] ; then
    PARAM_KEY="/Build/CodeBuild/Image"
fi

REGION=$(aws configure get region)
ACCOUNT_ID=$(aws sts get-caller-identity --output text | awk '{print $1}')
CONTAINER_URL="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${NAME}:${TAG}"

###
# ECR repo for container needs to exist
###
echo "Building and pushing container ${CONTAINER_URL}"
$(aws ecr get-login --no-include-email --region us-west-2)
docker build -t ${CONTAINER_URL} .
docker push ${CONTAINER_URL}

echo "Updating param ${PARAM_KEY} with ${CONTAINER_URL}"
aws ssm put-parameter --name ${PARAM_KEY} --type String --value ${CONTAINER_URL} --overwrite

