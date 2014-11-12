# Description:
#   Display random generated class name from classnamer.com 
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot class  - generate a random class name from classnamer.com
#
# Author:
#   pzelnip 
#
module.exports = (robot) ->
  robot.respond /class/i, (msg) ->
    msg
      .http("http://www.classnamer.com/index.txt?generator=generic")
      .get() (err, res, body) ->
        msg.send body
