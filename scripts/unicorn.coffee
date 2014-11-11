# Description:
#   Returns a unicorn gravatar based on the specified string
#
# Author:
#   Craig Thomas
#
# Commands:
#   hubot unicorn <string> - get the unicorn gravatar of the hashed string

crypto = require('crypto');

module.exports = (robot) ->
  robot.respond /unicorn (.+)/i, (msg) ->
    unicornMe msg, (url) ->
      msg.send url

unicornMe = (msg, cb) ->
  unicornHash = crypto.createHash('md5').update(msg.match[1]).digest("hex")
  cb "http://unicornify.appspot.com/avatar/#{unicornHash}?s=128#.png"
