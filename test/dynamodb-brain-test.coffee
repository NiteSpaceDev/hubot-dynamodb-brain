Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../src/dynamodb-brain.coffee')

describe 'dynamodb-brain', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'responds to brainscan', ->
    @room.user.say('alice', '@hubot brainscan').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot brainscan']
        ['hubot', '@alice My brain is doing great!']
      ]
