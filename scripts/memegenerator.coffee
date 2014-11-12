# Description:
#   Produces meme images from Memegenerator.net
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_MEMEGEN_USERNAME
#   HUBOT_MEMEGEN_PASSWORD
#
# Commands:
#   hubot meme "<query>" "<line0>" "<line1>" - generates a meme image the image found by searching for <query> and having the two lines 
#   hubot memesearch "<query>" - returns the top rated image on Memegenerator for <query> 
#
# Notes:
#   Example: hubot meme "gandalf" "you shall" "not pass"
#
# Author:
#   aparkin 

module.exports = (robot) ->
    robot.respond /meme \"(.+)\" \"(.*)\" \"(.*)\"/i, (msg) ->
#        msg.send "Memegenerator is disabled until Memegenerator.net comes back online"
        query = escape(msg.match[1])
        line0 = escape(msg.match[2])
        line1 = escape(msg.match[3])
        getImage(query, line0, line1, msg, true)

    robot.respond /memesearch \"(.+)\"/i, (msg) ->
#        msg.send "Memegenerator is disabled until Memegenerator.net comes back online"
        query = escape(msg.match[1])
        getImage(query, "", "", msg, false)


# First call to the Memegenerator API, does a search for the given query and
# picks the top hit (most popular image for the query).  It then passes the
# parameters for that image to okNowDoMemeGeneration
getImage = (query, line0, line1, msg, generatememe = true) ->
    queryurl = "http://version1.api.memegenerator.net/Generators_Search?q=#{query}"
    msg.http(queryurl)
        .get() (err, res, body) ->
            try
                result = JSON.parse(body).result
        
                if result.length != 0
                    generatorID = result[0].generatorID
                    imageUrl = result[0].imageUrl

                    [first, mid..., filename] = imageUrl.split "/"
                    [imageID, mid..., last] = filename.split /\./

                    if generatememe
                        okNowDoMemeGeneration(generatorID, imageID, line0, line1, msg)
                    else
                        msg.send imageUrl
                else
                    msg.send "No search hits for #{query} (create a new image at http://memegenerator.net/create/generator)"
        
            catch error
                msg.send "Error retrieving generatorID & imageID"

# 2nd call to the Memegenerator API, given an image (identified by generatorID,
# and imageID), produces the image and spits it back to the channel.
okNowDoMemeGeneration = (generatorID, imageID, line0, line1, msg) ->
    username = process.env.HUBOT_MEMEGEN_USERNAME
    password = process.env.HUBOT_MEMEGEN_PASSWORD
    unless username? and password?
        msg.send "MemeGenerator account isn't setup. Sign up at http://memegenerator.net"
        msg.send "Then ensure the HUBOT_MEMEGEN_USERNAME and HUBOT_MEMEGEN_PASSWORD environment variables are set"
        return
    url = "http://version1.api.memegenerator.net/Instance_Create?username=#{username}&password=#{password}&languageCode=en&generatorID=#{generatorID}&imageID=#{imageID}&text0=#{line0}&text1=#{line1}"
    
    msg.http(url)
        .get() (err, res, body) ->
            try
                json = JSON.parse(body)
                msg.send json.result.instanceImageUrl
            catch error
                msg.send "Error generating meme image"
 
