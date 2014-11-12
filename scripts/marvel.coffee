# Description:
#   Query the Marvel Comics API for info about a Marvel character
#
# Dependencies:
#   None
#
# Configuration:
#   MARVEL_PRIVATE_KEY - your private Marvel API key
#   MARVEL_PUBLIC_KEY - your private Marvel API key
#
# Commands:
#   hubot marvel <character> - gives information about <character>
#
# Author:
#   pzelnip

pubkey = process.env.HUBOT_MARVEL_PUBLIC_KEY
privkey = process.env.HUBOT_MARVEL_PRIVATE_KEY

module.exports = (robot) ->
  robot.respond /marvel (.*)/i, (msg) ->
    msg.send msg.match[1] + "'" + pubkey + "'  '" + privkey + "'" 



