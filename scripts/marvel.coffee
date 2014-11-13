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

crypto = require('crypto');

pubkey = process.env.HUBOT_MARVEL_PUBLIC_KEY
privkey = process.env.HUBOT_MARVEL_PRIVATE_KEY

module.exports = (robot) ->
  robot.respond /marvel (.*)/i, (msg) ->

    ts = "" + new Date().getTime()
    m = crypto.createHash('md5')
    m.update(ts)
    m.update(privkey)
    m.update(pubkey)
    md5hash2 = m.digest("hex")
    char = escape(msg.match[1])
    url = "http://gateway.marvel.com:80/v1/public/characters?&apikey=#{pubkey}&ts=#{ts}&hash=#{md5hash2}&name=#{char}"

    msg.http(url)
      .get() (err, res, body) ->
        try
          data = JSON.parse(body).data

          if data.results.length != 0
            result = data.results[0]

            desc = result.description or "No description available" 

            thumbnail = "No thumbnail available"
            if result.thumbnail and result.thumbnail.path and result.thumbnail.extension
                thumbnail = result.thumbnail.path + "." + result.thumbnail.extension

            wiki = "No Wiki link available"
            detail = "No detail link available"
            if result.urls.length != 0
                for url in result.urls
                    if url.type == "wiki"
                        wiki = url.url
                    if url.type == "detail"
                        detail = url.url

            msg.send "Description: #{desc}\nWiki: #{wiki}\nDetail: #{detail}\nThumbnail: #{thumbnail}"
          else
            msg.send "No data available for #{char}"
        catch error
          msg.send "Error retrieving Marvel Char info"


