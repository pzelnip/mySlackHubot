# Description:
#   Have hubot display the current calendar month
#   https://leanpub.com/automation-and-monitoring-with-hubot/read
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot calendar [me] - shows the current calendar
#
# Author:
#   Tomas Varaneckas


child_process = require('child_process')

module.exports = (robot) ->
  robot.respond /calendar( me)?/i, (msg) ->
    child_process.exec 'cal -h', (error, stdout, stderr) ->
      msg.send(stdout)

