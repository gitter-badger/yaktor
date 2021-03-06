/* global describe, it */
process.env.NODE_CONFIG = JSON.stringify({
  yaktor: {
    log: {
      stdout: true,
      level: 'info',
      filename: ''
    }
  }
})
var path = require('path')
var assert = require('assert')
require('mongoose-shortid-nodeps')
require(path.resolve('src-gen', 'test'))
var mongoose = require('mongoose')
var mockgoose = require('mockgoose')
mockgoose(mongoose)
var proxyquire = require('proxyquire')
var ObjectId = mongoose.Types.ObjectId // eslint-disable-line no-unused-vars
var proxy = { // eslint-disable-line no-unused-vars
  'mongoose': Global(mongoose)
}

function Global (m) {
  m[ '@noCallThru' ] = true
  m[ '@global' ] = true
  return m
}
var yaktor = Global({
  log: {
    level: 'info',
    stdout: true,
    filename: ''
  }
})
describe('shortId', function () {
  it('should create shortId with the longer default', function (done) {
    var DefaultShort = mongoose.model('DefaultShort')
    var ds = new DefaultShort({
      name: 'name'
    })
    ds.save(function () {
      assert.equal(ds.id.length, 7)
      done()
    })
  })
  it('should create shortId of default length', function (done) {
    var proxy = {
      'yaktor': yaktor,
      'yaktor/logger': Global(proxyquire('../logger', { '../index': yaktor })),
      'mongoose-shortid-nodeps': Global(require('mongoose-shortid-nodeps'))
    }
    proxyquire(path.resolve('bin', 'static', 'config', 'global', '02_shortid'), proxy)
    var DefaultShort = mongoose.model('DefaultShort')
    var ds = new DefaultShort({
      name: 'name'
    })
    ds.save(function () {
      assert.equal(ds.id.length, 7)
      done()
    })
  })
  it('should create shortId of default length', function (done) {
    var CustomShort = mongoose.model('CustomShort')
    var ds = new CustomShort({
      name: 'name'
    })
    ds.save(function () {
      assert.equal(ds.id.length, 6)
      done()
    })
  })
})
