-- Demonstrates sprite sheet animations, with different frame rates
-- 
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.



system.activate( "multitouch" )
widget = require( "widget" )

local physics = require("physics")
physics.start()


local isDebug=false--true


if (isDebug) then
    physics.setDrawMode( 'debug' )
end

display.setStatusBar( display.HiddenStatusBar )



--INCLUDES
require( "ice" )
local advertising = require("advertising")


local movieclip = require("movieclip")
local background = require( "background" )
local world = require( "world" )
local levels = require( "levels" )
local loadsounds = require( "loadsounds" )

local sprite_collection = require( "sprite_collection" )
--local movements = require "movements"
--      character = require "character"
local usercharacter = require "usercharacter"
local mousecharacter = require "mousecharacter"
local demo = require "demo"
local saveload = require( "saveload" )
local buttons = require( "buttons" )
local thegame = require( "thegame" )
local winform = require( "winform" )
local loseform = require( "loseform" )
local theendform = require( "theendform" )

local mainmenu = require( "mainmenu" )
local settingsform = require( "settingsform" )
local helpform = require( "helpform" )

local userstate = ice:loadBox( "userstate" )
thegame.MaxLevel=userstate:retrieve( "maxlevel" )
thegame.CurrentLevel=userstate:retrieve( "currentlevel" )
thegame.PlaySound=userstate:retrieve( "playsound" )
thegame.PlayMusic=userstate:retrieve( "playmusic" )
if thegame.MaxLevel==nil or thegame.CurrentLevel==nil or thegame.PlaySound==nil  or thegame.PlayMusic==nil  then
    local userstate = ice:loadBox( "userstate" )
    userstate:store( "maxlevel", 1 )
    userstate:store( "currentlevel", 0 )
    userstate:store( "playsound", true )
    userstate:store( "playmusic", true )
    userstate:save()
    thegame.MaxLevel=1
    thegame.CurrentLevel=0
    thegame.PlaySound=true
    thegame.PlayMusic=true

end

--thegame.MaxLevel=9 --for debug only





--thegame.CurrentLevel=4--0--4--0
--thegame.MaxLevel=1--5--1--thegame.CurrentLevel

thegame.TotalScores=0
thegame.CurrentLevelScores=0

buttons.physics_paused=true

sprite_collection:AddSprites()
-- Create master display group (for global "camera" scrolling effect)



-- Load Sounds
--thegame.PlaySound=false
--thegame.PlayMusic=false
loadsounds:loadSounds();


advertising:PrepareAds()

if thegame.CurrentLevel>0 then 
    mainmenu:OpenMainMenu(false,false);
else
    mainmenu:OpenMainMenu(false,true); -- beginning of the game + tutorial
end



local function moveCamera()
    
    world:moveCamera();
end

--function removeKeyEvent()
    
--end


function onKeyEvent_Main( event )
    local keyName = event.keyName;
    if (event.phase == "up" and (keyName=="back" or keyName=="menu")) then

            Runtime:removeEventListener( "key", onKeyEvent_Main )
            
            if keyName=="menu" then
                buttons:MenuEvent();
            else
                --buttons:MenuEvent();
                buttons:QuitDialog();
            end
        return true;
    else
        return false;
    end
    
end

function enableKeyEvent_Main()
    if system.getInfo( "platformName" ) == "Android" then  
        Runtime:addEventListener( "key", onKeyEvent_Main )
    end
end

background:CreateSky()


local Timers={}
function EraseAllTimers()
    for i=1, #Timers do
            timer.cancel( Timers[i] ) 
            Timers[i]=nil
    end
    Timers={}
end


function LoadLevel(self)
    EraseAllTimers()
    buttons.physics_paused=true
    advertising:HideAd();
    thegame:StopAllPlaying();
    
      
    CurrentLevelScores=0
        
    
   
    print("Load level -step 2")
    
    levels:CreateLevel(thegame.CurrentLevel)
    
    
    world:SetBackground(0)
    game = display.newGroup();
    game.isVisible=false
    physics.start()  

    
    world:SetWalls()
    thegame.PrepareSpriteArraw()
    local strLevel=levels:Bodies(thegame.CurrentLevel)
    saveload:loadLevelFromString(strLevel)
    
    if(world.TrapSensor~=nil and world.TrapSensor.x~=nil) then
        game.x = -world.TrapSensor.x+240
    else
        game.x=0
    end
    game.y = 0  
    
    usercharacter:drawCharacter(thegame.UserPositionX,thegame.UserPositionY)
    
    world:SetBackground(1)
    thegame.CameraWatch=1
    
    thegame:setSkyDropListener()
    

    buttons.GameMode=1
    
    
    if(mousecharacter.wheel~=nil and mousecharacter.wheel.x~=nil) then
        WatchScreenX=math.floor(mousecharacter.wheel.x)
    else
        WatchScreenX=0
    end
    
    mousecharacter.ReadyToTurn=false
    
    thegame.CameraSpeed=80
    
    
    thegame.FindNextSprite()
    
    if (thegame.PlayMusic) then
        local fileFormat=".wav"
        local background_melody= audio.loadSound("src/music/sounds-toy-melody"..fileFormat)
        local availableChannel = audio.findFreeChannel()
        audio.setVolume( 0.5, { channel=availableChannel } )
        audio.play( background_melody, { channel=availableChannel,loops=-1 } )
        thegame.BackGroundMusicChannel=availableChannel
    else
            thegame.BackGroundMusicChannel=-1
    end
    
    
    if(thegame.CurrentLevel==1) then
        local x=thegame.UserPositionX+160
        
        demo:drawFinger(x,display.contentHeight+100)
    
        demo:moveTo(x,display.contentHeight-100,4000,1.5,1,1000)
        demo:moveTo(x+200,display.contentHeight-200,7000,1,1,500)
        demo:removeMe(8500)
        
        
        
        thegame:DropBodyDemo(8000,x+250,display.contentHeight-100,1600,x,display.contentHeight)
    end
   
    buttons.physics_paused=false
    print ("Move Camera")
    moveCamera()
    
    background.sky.isVisible=true
    game.isVisible=true
    
    
    
    
    if levels.ShowAds then
        advertising:ShowAd("text")
    end
    
    local toDo=function()
        buttons:createGameButtons()
    end
    Timers[#Timers]=timer.performWithDelay(500,toDo,1)
    
    buttons.isGamePlaying=true
    
    if system.getInfo( "platformName" ) == "Android" then  
        Runtime:addEventListener( "key", onKeyEvent_Main )
    end
    
    Runtime:addEventListener( "enterFrame", moveCamera )
    
    
    
    
    collectgarbage()
    print( "MemUsage: " .. collectgarbage("count") )
    local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
    print( "TexMem:   " .. textMem )


    
    
end

function remove_enterFrameListener(self)
    Runtime:removeEventListener( "enterFrame", moveCamera )
end

if isDebug then
    LoadLevel()
end


function DoSystemEvents(event)
    
    --if system.getInfo( "environment" ) ~= "simulator" then
    --end
    
    
    if event.type=="applicationSuspend" then
            --os.exit();
            
            print ("Suspend");
            if(buttons.isGamePlaying) then
                print ("Pause Game");
                buttons:PauseGame(false);
            end
    end
    if event.type == "applicationExit" then

        --buttons:QuitDialog()

    end
    
    
end



Runtime:addEventListener( "system", DoSystemEvents )

