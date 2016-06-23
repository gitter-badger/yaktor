var logger = require('yaktor/logger')
logger.info(__filename)
var dns = require('dns')
var os = require('os')

module.exports = function (ctx, done) {
  var port = ctx.host.port
  var i = parseInt(port)
  if (port.toString() !== i.toString()) return done(new Error('server %s setting host.port is not an integer', ctx.serverName))
  port = i

  ctx.server.listen(port, function (err) {
    if (err) return done(err)
    dns.lookup(os.hostname(), function (err, ip) { // eslint-disable-line handle-callback-err
      var protocol = ctx.host.protocol
      var p = ((protocol === 'http' && port === 80) || (protocol === 'https' && port === 443)) ? '' : (':' + port)
      logger.info('server %s listening at %s', ctx.serverName, ip ? (protocol + '://' + ip + p) : ('port ' + port))
      done()
    })
  })
}
