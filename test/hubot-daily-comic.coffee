chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
requireSubvert = require('require-subvert')(__dirname)
DailyComic = require 'daily-comic.js'

expect = chai.expect

describe 'hubot-daily-comic', ->
    beforeEach ->
        @robot =
            respond: sinon.spy()

        @stub = sinon.createStubInstance(DailyComic)
        requireSubvert.subvert 'daily-comic.js', sinon.stub().returns(@stub)

        requireSubvert.require('../src/hubot-daily-comic')(@robot)

    afterEach ->
        requireSubvert.cleanUp

    it 'registers a respond listener', ->
        expect(@robot.respond).to.have.been.calledOnce

    it 'registers a listener with daily-comic', ->
        expect(@stub.on).to.have.been.calledOnce