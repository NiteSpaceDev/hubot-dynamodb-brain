# hubot-dynamodb-brain

A hubot brain built on DynamoDB

See [`src/dynamodb-brain.coffee`](src/dynamodb-brain.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-dynamodb-brain --save`

Then add **hubot-dynamodb-brain** to your `external-scripts.json`:

```json
[
  "hubot-dynamodb-brain"
]
```

## Defaults:

This brain is written with the assumption that the hubot instance is running on an AWS instance, with an instance role that allows access to the 'hubotbrain' table in the current region.   Environment variables are available to override.

The following CloudFormation YAML will create a suitable table in DynamoDB:
```yaml
HubotBrainDynamo:
    Type: "AWS::DynamoDB::Table"
    Properties:
      TableName: hubotbrain
      AttributeDefinitions:
        - AttributeName: "botname"
          AttributeType: "S"
      KeySchema:
        - AttributeName: "botname"
          KeyType: "HASH"
      ProvisionedThroughput:
        ReadCapacityUnits: 1
        WriteCapacityUnits: 1
```

## Sample Interaction
```
user1>> hubot brainscan
hubot>> My brain is doing great!
```

## NPM Module

https://www.npmjs.com/package/hubot-dynamodb-brain
