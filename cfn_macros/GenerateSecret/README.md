# GenerateSecret CloudFormation Macro

Transform that will provide a reference to the latest version of a SecureString in AWS Systems Manager Parameter Store. If a SecureString does not exist then one will be generated and reference to the new SecureString will be provided.

## Basic Usage

Place the transform where you would like the reference to the SecureString to be included in the template. Note that a reference to a SecureString can only be used be [specific resources](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/dynamic-references.html#template-parameters-dynamic-patterns-resources).

The example below shows using a SecureString reference to set the MasterUserPassword of an RDS instance.

```yaml
AWSTemplateFormatVersion: 2010-09-09
Parameters:
  DbPasswordParam:
    Type: String
    Default: /Dev/Db/admin
Resources:
  DB:
    Type: AWS::RDS::DBInstance
    Properties:
      AllocatedStorage: 20
      DBInstanceClass: db.t2.small
      Engine: MySQL
      MasterUsername: admin
      MasterUserPassword:
        Fn::Transform:
          - Name: GenerateSecret
            Parameters:
              SecretName: !Ref DbPasswordParam
              Exclude:
                - '"'
                - '/'
                - '@'
```

In this case if the SecureString `/Dev/Db/admin` exists then the a reference to latest version will be provided. If `/Dev/Db/admin` does not exist, then a new SecureString will be created and a reference to that SecureString will be provided.

## Parameters
The only required parameter is `SecretName`, which with be used as the SecureString name stored in the AWS Systems Manager Parameter Store. In addition to `SecretName` the other optional parameters can be provided.

### Length - Default: 16

The number of characters that will be used to make the SecureString. By default all characters types will be used, so this needs to be 4 or greater.

### Lower - Default: True

Boolean if lower case letters should be included in the SecureString.

### Upper - Default: True

Boolean if lower case letters should be included in the SecureString.

### Number - Default: True

Boolean if numbers should be included in the SecureString.

### Special - Default: True

Boolean if special characters (i.e. punctuation) should be included in the SecureString.

### Exclude - Default: None

List of characters that should not be included in the SecureString.

## Warranty
This is proof of concept code used to showcase CloudFormation Macros and System Manager SecureString references in CloudFormation. This code generates a string that can be used as a password, but there is no guarentee this string is generated in a secure manner and sufficient to meet your needs. It's recommended that you evaluate the `generate_secret` included in the Lambda Function to determine if it satisfactory for your use case.

