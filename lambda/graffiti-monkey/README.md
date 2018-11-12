## Build Lambda Artifact and Upload To S3

Makefile takes care of everything for you. 
It also cleans up after the upload is successful. 

Just set a few environment variables (S3 Bucket, aws cli profile)

```sh
export BUCKET=bct-aws-tools-graffiti-monkey
export PROFILE=bct_sandbox

make build
```

### AWS Lambda Deployment via Cloudformation

```sh
export REGION=us-west-2
export SNS_ARN=mySnsArn

aws cloudformation deploy \
	--profile bct_sandbox \
	--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
	--stack-name ${STACK_NAME} \
	--template-file graffiti-monkey.yaml \
	--parameter-overrides \
	"Bucket=${BUCKET}"
	"Region=${REGION}"
	"SnsArn=${SNS_ARN}"
	"CodeArtifact=graffiti-monkey-date-from-build.zip"
```

Environment variables for the Graffiti Monkey Lambda Function itself can be set via command line, a parameters file, or by editing the Cloudformation template parameters in the yaml. 

```sh
INSTANCE_TAGS_TO_PROPAGATE
VOLUME_TAGS_TO_PROPAGATE
VOLUME_TAGS_TO_BE_SET
SNAPSHOT_TAGS_TO_BE_SET
INSTANCE_FILTER
```