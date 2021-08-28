--
-- Project: MadMouse
-- Description: 
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 . All Rights Reserved.
-- 

------------------------------------------------------------------------
-- Construct castle (body type defaults to "dynamic" when not specified)

module(..., package.seeall)


function loadSounds(self)
    local fileFormat=".wav"
    
--if(thegame.PlaySound) then
    --local bombSound = gameUI.loadSoundXP( { ios="bomb_caf.caf", android="bomb_wav.wav" } )
    
    
    thegame.winSounds[1]= audio.loadSound("src/sounds/win_eeeha"..fileFormat)
    thegame.winSounds[2]= audio.loadSound("src/sounds/win_yippie"..fileFormat)

    thegame.loseSounds[1]= audio.loadSound("src/sounds/sounds_lose_1"..fileFormat)
    thegame.loseSounds[2]= audio.loadSound("src/sounds/sounds_lose_2"..fileFormat)

    thegame.tryagainSounds[1]= audio.loadSound("src/sounds/sounds_tryagain_1"..fileFormat)


    thegame.trapSounds[1]= audio.loadSound("src/sounds/trap_sound"..fileFormat)

    thegame.bodyFlySounds[1]= audio.loadSound("src/sounds/sounds_fly_by_1"..fileFormat)
    thegame.bodyFlySounds[2]= audio.loadSound("src/sounds/sounds_fly_by_2"..fileFormat)
    thegame.bodyFlySounds[3]= audio.loadSound("src/sounds/sounds_fly_by_3"..fileFormat)
    thegame.bodyFlySounds[4]= audio.loadSound("src/sounds/sounds_fly_by_4"..fileFormat)
    thegame.bodyFlySounds[5]= audio.loadSound("src/sounds/sounds_fly_by_5"..fileFormat)
    thegame.bodyFlySounds[6]= audio.loadSound("src/sounds/sounds_fly_by_6"..fileFormat)
    --thegame.bodyFlySounds[2]= audio.loadSound("src/sounds/body_book2.wav")

    thegame.bodyHitSounds[1]= audio.loadSound("src/sounds/sounds_ball_hit_1"..fileFormat) -- tennis
    thegame.bodyHitSounds[2]= audio.loadSound("src/sounds/sounds_wood_hit_1"..fileFormat) -- bedstay
    thegame.bodyHitSounds[3]= audio.loadSound("src/sounds/sounds_ball_hit_2"..fileFormat) -- bascetball, football
    thegame.bodyHitSounds[4]= audio.loadSound("src/sounds/sounds_book_hit_1"..fileFormat) -- book
    thegame.bodyHitSounds[5]= audio.loadSound("src/sounds/sounds_bag_hit_1"..fileFormat) -- bag
    thegame.bodyHitSounds[6]= audio.loadSound("src/sounds/sounds_box_hit_1"..fileFormat) -- bag
    
    
    
    
    
    
    --thegame.bodyHitSounds[2]= audio.loadSound("src/sounds/body_book1.wav")
    --thegame.bodyHitSounds[3]= audio.loadSound("src/sounds/body_book2.wav")
    --thegame.mousePainSounds[1]= media.newEventSound( "sounds_mouse_pain_1"..fileFormat )
    thegame.mousePainSounds[1]= audio.loadSound("src/sounds/sounds_mouse_pain_1"..fileFormat )
    thegame.mousePainSounds[2]= audio.loadSound("src/sounds/sounds_mouse_pain_2"..fileFormat )
    --thegame.mousePainSounds[3]= audio.loadSound("src/sounds/sounds_mouse_pain_3"..fileFormat )
    thegame.mousePainSounds[3]= audio.loadSound("src/sounds/sounds_mouse_pain_4"..fileFormat )
    
    thegame.mouseEatSounds[1]= audio.loadSound("src/sounds/sounds_mouse_eating_1"..fileFormat )
    thegame.mouseEatSounds[2]= audio.loadSound("src/sounds/sounds_mouse_eating_2"..fileFormat )
    thegame.mouseEatSounds[3]= audio.loadSound("src/sounds/sounds_mouse_eating_3"..fileFormat )
    
    thegame.mouseJumpSounds[1]= audio.loadSound("src/sounds/sounds_mouse_jump"..fileFormat )
    
    thegame.userDropSounds[1]= audio.loadSound("src/sounds/sounds_user_drop_1"..fileFormat )
    thegame.userDropSounds[2]= audio.loadSound("src/sounds/sounds_user_drop_4"..fileFormat )
    --thegame.userDropSounds[2]= audio.loadSound("src/sounds/sounds_user_drop_2"..fileFormat )
    --thegame.userDropSounds[3]= audio.loadSound("src/sounds/sounds_user_drop_3"..fileFormat )
    
    
--end


end
