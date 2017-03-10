chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
requireSubvert = require('require-subvert')(__dirname)
DailyComic = require 'daily-comic.js'

expect = chai.expect

describe 'hubot-daily-comic', ->
  beforeEach ->
    process.env.HUBOT_ANNOUNCE_ROOMS = ['someroom']

    @robot =
      respond: sinon.spy()
      messageRoom: sinon.spy()
      logger:
        error: sinon.spy()

    @stub = sinon.createStubInstance(DailyComic)
    requireSubvert.subvert 'daily-comic.js', sinon.stub().returns(@stub)

    @msg =
      match: [ '', '', '', '', 'somecomic' ]
      send: sinon.spy()

    requireSubvert.require('../src/hubot-daily-comic')(@robot)

  afterEach ->
    requireSubvert.cleanUp

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledOnce

  it 'registers two listeners with daily-comic', ->
    expect(@stub.on).to.have.been.calledTwice

  it 'retrieves the comic and responds with the url', ->
    @stub.get = sinon.stub().returns({url: 'someurl'})

    cb = @robot.respond.firstCall.args[1]
    cb(@msg)

    expect(@stub.get).to.have.been.calledOnce
    expect(@msg.send).to.have.been.calledWith('someurl')

  it 'retrieves the comic and on no result responds with an error', ->
    @stub.get = sinon.stub().returns(null)

    cb = @robot.respond.firstCall.args[1]
    cb(@msg)

    expect(@stub.get).to.have.been.calledOnce
    expect(@msg.send).to.have.been.calledWithMatch(sinon.match('error'))

  it 'announces a new comic in all defined rooms', ->
    cb = @stub.on.firstCall.args[1]
    cb('somecomic', {url: 'someurl'})

    expect(@robot.messageRoom).to.have.been.calledWithMatch(sinon.match('someroom'), sinon.match('someurl'))

  it 'logs an error to the robot logger', ->
    cb = @stub.on.secondCall.args[1]
    cb('someError')

    expect(@robot.logger.error).to.have.been.calledWith('someError')