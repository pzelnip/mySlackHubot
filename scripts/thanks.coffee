# Description:
#   Hubot responds any thank message politely. Phrases from:
#   http://www.macmillandictionary.com/thesaurus-category/british/Ways-of-accepting-someone-s-thanks
#   Inspired by both https://github.com/sukima/river-song/blob/master/scripts/thanks.coffee
#   and
#   https://github.com/hubot-scripts/hubot-thank-you
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot thank[s] [you] - Hubot accepts your thanks
#   thanks hubot - same
#
# Author:
#   github.com/pzelnip
#   github.com/delucas
#   github.com/sukima
#

pick_one = (array) ->
  i = Math.floor(Math.random() * array.length)
  array[i]

punc = [
  "", "!", ".", "!!"
]

phrases = [
  "you're welcome",
  "no problem",
  "not at all",
  "don’t mention it",
  "it’s no bother",
  "it’s my pleasure",
  "my pleasure",
  "it’s all right",
  "it’s nothing",
  "think nothing of it",
  "sure",
  "sure thing"
]

emoji = ["", "", "", ":smile:", ":+1:", ":ok_hand:", ":punch:",
  ":bowtie:", ":smiley:", ":heart:", ":trollface:", ":heartbeat:",
  ":sparkles:", ":star:", ":star2:", ":smirk:", ":grinning:",
  ":smiley_cat:", ":sunflower:", ":tulip:", ":hibiscus:", ":cherry_blossom:"]

youre_welcome = () ->
  [pick_one(phrases), pick_one(punc), " ", pick_one(emoji)].join('')

module.exports = (robot) ->
  robot.hear ///(thx|thanks|thank\s+you),?\s+#{robot.name}///i, (msg) ->
    msg.send youre_welcome()
  robot.respond /(thx|thanks|thank you)/i, (msg) ->
    msg.send youre_welcome()
