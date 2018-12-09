#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]] ; do
    key="$1"
    case ${key} in
        --container)
        TAG_TYPE=container
        shift
        ;;
        --chart)
        TAG_TYPE=chart
        shift
        ;;
        --latest)
        TAG_TYPE=latest
        shift
        ;;
    esac
done

CURRENT_SHA=$(git rev-parse HEAD)
CURRENT_SHA_SHORT=$(git rev-parse --short=8 HEAD)
LATEST_TAG=$(git describe --abbrev=0 --tags)
TAG_SHA=$(git show ${LATEST_TAG} -s --format=format:%H)


if [ ${CURRENT_SHA} != ${TAG_SHA} ] ; then
    case ${TAG_TYPE} in
        container)
        TAG="dev-${CURRENT_SHA_SHORT}"
        ;;
        chart)
        TAG="${LATEST_TAG}-dev+${CURRENT_SHA_SHORT}"
        ;;
        latest)
        TAG="false"
        ;;
    esac
else
    case ${TAG_TYPE} in
        latest)
        TAG="true"
        ;;
        *)
        TAG="${LATEST_TAG}"
        ;;
    esac

fi

echo ${TAG}