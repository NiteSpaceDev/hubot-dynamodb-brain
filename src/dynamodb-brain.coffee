# Description
#   A hubot brain built on DynamoDB
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
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

module.exports = (robot) ->
  robot.respond /brainscan/, (res) ->
    res.reply "I have a brain?"

