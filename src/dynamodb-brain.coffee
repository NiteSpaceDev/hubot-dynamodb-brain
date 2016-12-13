# Description
#   A hubot brain built on DynamoDB
#
# Configuration:
# HUBOT_AWS_REGION - Default to us-east-2 if not set
# HUBOT_BRAIN_DYNAMO_TABLE - DynamoDB table, default hubotbrain
# HUBOT_DYNAMO_NAME - Brain entry in table, default is our robot name
# HUBOT_AWS_ACCESS_KEY_ID - AWS Credentials, default to instance IAM
# HUBOT_AWS_SECRET_ACCESS_KEY - AWS Credentials, default to instance IAM
#
# Commands:
#   hubot brainscan - Check to make sure our brain is working
#
# Notes:
#   This bot requires the DynamoDB table to exist prior to running.
#   See Readme for CFT snippet to create table
#
# Author:
#   Nitehawk <nitehawk@nitespace.co>

AWS = require 'aws-sdk'

module.exports = (robot) ->
  config = {}
  params = {}
  creds = {}

  config.region = process.env.HUBOT_AWS_REGION or 'us-east-2'
  params.TableName = process.env.HUBOT_BRAIN_DYNAMO_TABLE or 'hubotbrain'
  params.Key = { botname: process.env.HUBOT_BRAIN_DYNAMO_NAME or robot.name }
  creds.access = process.env.HUBOT_AWS_ACCESS_KEY_ID or undefined
  creds.secret = process.env.HUBOT_AWS_SECRET_ACCESS_KEY or undefined


  if creds.access and creds.secret
    config.accessKeyId = creds.access
    config.secretAccessKey = creds.secret

  AWS.config.update config

  doc = new AWS.DynamoDB.DocumentClient

  saveBrain = (data = {}) ->
    console.log "Saving brain"
    brain = {TableName: params.TableName, Item: data}
    brain.Item.botname = params.Key.botname
    doc.put brain, (err, res) ->
      if err
        robot.logger.error err

  loadBrain = (params) ->
    robot.brain.setAutoSave false

    doc.get params, (err, data) ->
      if err
        throw err
      else if data
        robot.logger.info "hubot-dynamodb-brain: Data for #{params.Key.botname} retrieved from Dynamo"
        robot.brain.mergeData data
      else
        robot.logger.info "hubot-dynamodb-brain: Initializing new brain for #{params.Key.botname}"
        robot.brain.mergeData {}

    robot.brain.setAutoSave true

  loadBrain params

  robot.brain.on 'save', (data = {}) ->
    saveBrain data

  robot.respond /brainscan/, (res) ->
    before = robot.brain.get "LastUser"
    res.reply "#{before} just asked me this!"
    robot.brain.set "LastUser", res.message.user.name
    res.reply "My brain is called '#{params.Key.botname}' and it's doing great!"

