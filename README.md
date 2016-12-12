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

By default, this brain assumes that a DynamoDB table named 'hubotbrain' exists with 'botname' as the primary key with type 'string'.

The following CloudFormation YAML will create such a table:
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
user1>> hubot hello
hubot>> hello!
```

## NPM Module

https://www.npmjs.com/package/hubot-dynamodb-brain
