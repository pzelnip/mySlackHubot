# Description:
#   Puts the space core from Portal 2 into your chat room
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot startspace <n> - starts the spacecore waiting <n> seconds between posts 
#   hubot stopspace - makes the space core stop talking 
#
# Notes:
#   None
#
# Author:
#   aparkin 

someCallback = (param, msg) ->
    callback = defineCallback(param, msg) 
    setInterval callback, param

defineCallback = (param, msg) ->
    () => 
        lines = ["Space, space, wanna go to space...",
                 "SPAAAAAAAAAAAAAAAAAAAAAAAAAAACE!",
                 "What's your favorite thing about space? Mine is space.",    "Space going to space can't wait.",    "Space...", 
                 "Space. Trial. Puttin' the system on trial. In space. Space system. On trial. Guilty. Of being in space! Going to space jail!",
                "Dad! I'm in space! (low-pitched 'space' voice) I'm proud of you, son. [normal voice] Dad, are you space? [low-pitched 'space' voice] Yes. Now we are a family again.",
                "Space space wanna go to space yes please space. Space space. Go to space.",    "Space space wanna go to space",    
                "Space space going to space oh boy",    "Ba! Ba! Ba ba ba! Space! Ba! Ba! Ba ba ba!",    "Oh. Play it cool. Play it cool. Here come the space cops.",    
                "Help me, space cops. Space cops, help.",    "Going to space going there can't wait gotta go. Space. Going.",
                "Better buy a telescope. Wanna see me. Buy a telescope. Gonna be in space.",    "Space. Space.",    "I'm going to space.",    "Oh boy.",    
                "Yeah yeah yeah okay okay.",    "Space. Space. Gonna go to space.",    "Space. Space. Go to space.",    "Yes. Please. Space.",    
                "Ba! Ba! Ba ba ba! Space!",    "Ba! Ba! Ba ba ba! Space!",    "Gonna be in space.",    "Space.",    "Space.",    "Ohhhh, space.",    
                "Wanna go to space. Space.",    "[humming]",    "Let's go - let's go to space. Let's go to space.",    "I love space. Love space.",    
                "Atmosphere. Black holes. Astronauts. Nebulas. Jupiter. The Big Dipper.",    "Orbit. Space orbit. In my spacesuit.",    "Space...",    
                "Ohhh, the Sun. I'm gonna meet the Sun. Oh no! What'll I say? 'Hi! Hi, Sun!' Oh, boy!",    "Look, an eclipse! No. Don't look.",    
                "Come here, space. I have a secret for you. No, come closer.",    "Space space wanna go to space",    "Wanna go to -- wanna go to space",    
                "Space wanna go wanna go to space wanna go to space",    "I'm going to space.",    "Space!",    "Space!",    "Hey hey hey hey hey!",    
                "Space.",    "Gotta go to space. Lady. Lady.",    "Oo. Oo. Oo. Lady. Oo. Lady. Oo. Let's go to space.",    
                "Oh I know! I know I know I know I know I know - let's go to space!",    
                "Oooh! Ooh! Hi hi hi hi hi. Where we going? Where we going? Hey. Lady. Where we going? Where we going? Let's go to space!",    
                "Lady. I love space. I know! Spell it! S P... AACE. Space. Space.",    "I love space.",    
                "Hey lady. Lady. I'm the best. I'm the best at space.",    "Oh oh oh oh. Wait wait. Wait I know. I know. I know wait. Space.",    
                "Wait wait wait wait. I know I know I know. Lady wait. Wait. I know. Wait. Space.",    "Gotta go to space.",    "Gonna be in space.",    
                "Oh oh oh ohohohoh oh. Gotta go to space.",    "Space. Space. Space. Space. Comets. Stars. Galaxies. Orion.",    
                "Are we in space yet? What's the hold-up? Gotta go to space. Gotta go to SPACE.",    "Going to space.",    
                "Yeah, yeah, yeah, I'm going. Going to space.",    "Love space. Need to go to space."] 
        idx = Math.floor(Math.random() * lines.length)
        msg.send "#{lines[idx]}"

module.exports = (robot) ->
    timerObj = null
    timeout = 5

    robot.respond /startspace (.+)/i, (msg) ->
        if timerObj
            msg.send "I'm already in spaaaaaaaaaaaaaaaaaaaaaaaaaaaaaace, and will tell you more every #{timeout} seconds"
        else
            n = msg.match[1] * 1000
            result = someCallback(n, msg)
            timerObj = result
            timeout = n / 1000
            msg.send "Going to space..."

    robot.respond /stopspace/i, (msg) ->
        if timerObj 
            clearInterval(timerObj)
            msg.send "Stopped going to space <sadface>..."
            timerObj = null
