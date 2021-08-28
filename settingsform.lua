--
-- Project: world.lua
-- Description: 
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 . All Rights Reserved.
-- 
module(..., package.seeall)

local c=175
local y=140

local ButtonBack=nil
local ButtonMusic=nil
local ButtonSound=nil
local ButtonReset=nil

local coverDeskSettings=nil
local settings_window=nil

local Timers={}
function EraseAllTimers()
    for i=1, #Timers do
            timer.cancel( Timers[i] ) 
            Timers[i]=nil
    end
    Timers={}
end

local AllTransition={}

local function CancelAllTransition()
    EraseAllTimers()
    for i=1, #AllTransition  do

        transition.cancel(AllTransition[i])
        AllTransition[i]=nil

    end
    i=nil
    AllTransition={}
end


function DoBack(self)
    CancelAllTransition()
    advertising:HideAd();
    
    display.remove(coverDeskSettings)
    coverDeskSettings=nil
    
    display.remove(settings_window)
    settings_window=nil
    
    mainmenu:ShowCoverButtons()
    
end

function MusicOff(event)
    if event.phase == "ended" then
        display.remove(ButtonMusic)
        ButtonMusic=nil

        thegame.PlayMusic=false
        
        if(thegame.BackGroundMusicChannel~=-1) then
            audio.stop(thegame.BackGroundMusicChannel)
        end
        thegame.BackGroundMusicChannel=-1
    
        local userstate = ice:loadBox( "userstate" )
        userstate:store( "playmusic", thegame.PlayMusic)
        userstate:save()
    
        ButtonMusic = widget.newButton{
            id="MusicOffButton",left=c-100,top=y,
            defaultFile = "src/images/buttons/button_music_off.png",
            overFile = "src/images/buttons/button_hover_music_off.png",
            onRelease =MusicOn,
            width=50,
            height=50
        }
        settings_window:insert (ButtonMusic)
    end
end

function MusicOn(event)
    if event.phase == "ended" then
        display.remove(ButtonMusic)
        ButtonMusic=nil

        thegame.PlayMusic=true
        if(thegame.BackGroundMusicChannel~=-1) then
            audio.stop(thegame.BackGroundMusicChannel)
        end
        thegame.BackGroundMusicChannel=-1
    
        local userstate = ice:loadBox( "userstate" )
        userstate:store( "playmusic", thegame.PlayMusic)
        userstate:save()

        ButtonMusic = widget.newButton{
            left=c-100,top=y,
            defaultFile = "src/images/buttons/button_music_on.png",
            overFile = "src/images/buttons/button_hover_music_on.png",
            onRelease =MusicOff,
            width=50,
            height=50
        }
        settings_window:insert (ButtonMusic)
        --ButtonMusic:setReferencePoint( display.CenterLeftReferencePoint )
        --ButtonMusic.x =c-100
        --ButtonMusic.y =y
    
        local fileFormat=".wav"
        local background_melody= audio.loadSound("src/music/sounds-toy-melody"..fileFormat)
        local availableChannel = audio.findFreeChannel()
        thegame.BackGroundMusicChannel=availableChannel
    
        audio.setVolume( 0.5, { channel=availableChannel } )
        audio.play( background_melody, { channel=availableChannel,loops=-1 } )

        local myclosure= function() audio.pause(thegame.BackGroundMusicChannel) end
        Timers[#Timers]=timer.performWithDelay(2500,myclosure,1)
    
    end
end


function SoundOff(event)
    if event.phase == "ended" then
        display.remove(ButtonSound)
        ButtonSound=nil

        thegame.PlaySound=false
    
        local userstate = ice:loadBox( "userstate" )
        userstate:store( "playsound", thegame.PlaySound)
        userstate:save()

        ButtonSound = widget.newButton{
            left=c,top=y,
            defaultFile = "src/images/buttons/button_sound_off.png",
            overFile = "src/images/buttons/button_hover_sound_off.png",
            onRelease =SoundOn,
            width=50,
            height=50
        }
        settings_window:insert (ButtonSound)
    end
end

function SoundOn(event)
    if event.phase == "ended" then
        display.remove(ButtonSound)
        ButtonSound=nil

        thegame.PlaySound=true
    
        local userstate = ice:loadBox( "userstate" )
        userstate:store( "playsound", thegame.PlaySound)
        userstate:save()

        ButtonSound = widget.newButton{
            left=c,top=y,
            defaultFile = "src/images/buttons/button_sound_on.png",
            overFile = "src/images/buttons/button_hover_sound_on.png",
            onRelease =SoundOff,
            width=50,
            height=50
        }
        settings_window:insert (ButtonSound)
        
    
        local availableChannel = audio.findFreeChannel()
        local index=math.random( #thegame.userDropSounds )
        audio.setVolume( 0.4, { channel=availableChannel } )
        audio.play( thegame.userDropSounds[index], { channel=availableChannel } )   
   end
end

local function BackEvent()
        Runtime:removeEventListener( "key", onKeyEvent )
    
    
        display.remove(ButtonBack)
        ButtonBack=nil
        display.remove(ButtonMusic)
        ButtonMusic=nil
        display.remove(ButtonSound)
        ButtonSound=nil
        display.remove(ButtonReset)
        ButtonReset=nil
        
        
        AllTransition[#AllTransition+1]=transition.to( coverDeskSettings, { time=200, alpha=0 } )
        Timers[#Timers]=timer.performWithDelay(200,DoBack,1)
end

function Back(event)
    if event.phase == "ended" then
        BackEvent()
    end
        
end
local function BackEvent()
        Runtime:removeEventListener( "key", onKeyEvent )
    
    
        display.remove(ButtonBack)
        ButtonBack=nil
        display.remove(ButtonMusic)
        ButtonMusic=nil
        display.remove(ButtonSound)
        ButtonSound=nil
        display.remove(ButtonReset)
        ButtonReset=nil
        
        
        AllTransition[#AllTransition+1]=transition.to( coverDeskSettings, { time=200, alpha=0 } )
        Timers[#Timers]=timer.performWithDelay(200,DoBack,1)
end
function DoReset()
    CancelAllTransition()
    advertising:HideAd();
    display.remove(coverDeskSettings)
    coverDeskSettings=nil
    
    display.remove(ButtonBack)
    ButtonBack=nil
    display.remove(ButtonMusic)
    ButtonMusic=nil
    display.remove(ButtonSound)
    ButtonSound=nil
    display.remove(ButtonReset)
    ButtonReset=nil
    
    
    display.remove(settings_window)
    settings_window=nil

    --reset game play
    thegame.MaxLevel=1
    thegame.CurrentLevel =0
    local userstate = ice:loadBox( "userstate" )
    userstate:store( "currentlevel", thegame.CurrentLevel )
    userstate:store( "maxlevel", thegame.MaxLevel )
    userstate:save()
    
    mainmenu:ResetTheGame()
    
    
end

function ResetConfirmed(event)
    if event.phase == "ended" then
        Runtime:removeEventListener( "key", onKeyEvent )
        
        AllTransition[#AllTransition+1]=transition.to( coverDeskSettings, { time=200, alpha=0 } )
        Timers[#Timers]=timer.performWithDelay(200,DoReset,1)
    end
end

function Reset(event)
    if event.phase == "ended" then
        
        display.remove(ButtonReset)
        ButtonReset=nil
    
        ButtonReset = widget.newButton{
            left=c+100,top=y,
            defaultFile = "src/images/buttons/button_reset.png",
            overFile = "src/images/buttons/button_hover_reset.png",
            onRelease =ResetConfirmed,
            width=50,
            height=50
        }
        settings_window:insert (ButtonReset)
    
        AllTransition[#AllTransition+1]=transition.to( ButtonReset, { time=300, y=y+118 } )

        --local onSimulator = system.getInfo( "environment" ) == "simulator"
        --local platformVersion = system.getInfo( "platformVersion" )
        --local olderVersion = tonumber(string.sub( platformVersion, 1, 1 )) < 4
        local fontName = "Grinched"
        local fontSize = 16
        local txt=nil
        if(thegame.GameLanguage=="rus") then
            fontName = "Basic Comical NC"
            txt="Хотите удалить историю игры? ";
        else
            txt="Do you want to delete game history? ";
        end

        local myText = display.newText(txt , 0, 0, fontName, fontSize )
        myText.x=c-50
        myText.y=y+120
        myText:setTextColor(250,250,250)
        settings_window:insert (myText) 
        
        AllTransition[#AllTransition+1]=transition.to( myText, { time=500, x=c-20 } )
   end
end


local function createButtons(self)


    ButtonBack = widget.newButton{
            left=c,top=70,
            defaultFile = "src/images/buttons/button_back.png",
            overFile = "src/images/buttons/button_hover_back.png",
            onRelease =Back,
            width=50,
            height=50
    }

    --ButtonBack:setReferencePoint( display.CenterLeftReferencePoint )
    --ButtonBack.x =c
    --ButtonBack.y =70
    settings_window:insert (ButtonBack)
           
    
    ----------------------
    if(thegame.PlayMusic) then 
        ButtonMusic = widget.newButton{
            left=c-100,top=y,
            defaultFile = "src/images/buttons/button_music_on.png",
            overFile = "src/images/buttons/button_hover_music_on.png",
            onRelease =MusicOff,
            width=50,
            height=50
        }
        settings_window:insert (ButtonMusic)
        --ButtonMusic:setReferencePoint( display.CenterLeftReferencePoint )
        --ButtonMusic.x =c-100
        --ButtonMusic.y =y
        
   else
        ButtonMusic = widget.newButton{
            left=c-100,top=y,
            defaultFile = "src/images/buttons/button_music_off.png",
            overFile = "src/images/buttons/button_hover_music_off.png",
            onRelease =MusicOn,
            width=50,
            height=50
        }
        settings_window:insert (ButtonMusic)
        --ButtonMusic:setReferencePoint( display.CenterLeftReferencePoint )
        --ButtonMusic.x =c-100
        --ButtonMusic.y =y
    end
    ---------------------
 
     if(thegame.PlaySound) then 
        ButtonSound = widget.newButton{
            left=c,top=y,
            defaultFile = "src/images/buttons/button_sound_on.png",
            overFile = "src/images/buttons/button_hover_sound_on.png",
            onRelease =SoundOff,
            width=50,
            height=50
        }
        settings_window:insert (ButtonSound)
        --ButtonSound:setReferencePoint( display.CenterLeftReferencePoint )
        --ButtonSound.x =c
        --ButtonSound.y =y
        
   else
        ButtonSound = widget.newButton{
            left=c,top=y,
            defaultFile = "src/images/buttons/button_sound_off.png",
            overFile = "src/images/buttons/button_hover_sound_off.png",
            onRelease =SoundOn,
            width=50,
            height=50
        }
        settings_window:insert (ButtonSound)
        --ButtonSound:setReferencePoint( display.CenterLeftReferencePoint )
        --ButtonSound.x =c
        --ButtonSound.y =y
    end
    
    
    
    ButtonReset = widget.newButton{
            left=c+100,top=y,
            defaultFile = "src/images/buttons/button_reset.png",
            overFile = "src/images/buttons/button_hover_reset.png",
            onRelease =Reset,
            width=50,
            height=50
    }
    --ButtonReset:setReferencePoint( display.CenterLeftReferencePoint )
    --ButtonReset.x =c+100
    --ButtonReset.y =y
    settings_window:insert (ButtonReset)
           
end


local function DrawSettingsWindow(self)
        

        coverDeskSettings = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDeskSettings:setFillColor(0,0,0, 250)
        coverDeskSettings:setReferencePoint( display.CenterCenterReferencePoint)
        coverDeskSettings.x=display.contentWidth*0.5
        coverDeskSettings.y=display.contentHeight*0.5
        coverDeskSettings.alpha=0
        AllTransition[#AllTransition+1]=transition.to( coverDeskSettings, { time=500, alpha=0.8 } )
                    
                        
	settings_window = display.newGroup();

        settings_window.width= 400
        settings_window.height= 263
        
	settings_window.x =display.contentWidth*0.5-200
	settings_window.y =-300-- 0-winner_window.height
        settings_window.alpha=1
        


        
        local board = display.newImage( "src/images/stages/settings.png",400,226 )
        board:setReferencePoint( display.TopLeftReferencePoint )
        board.x=0
        board.y=0
	settings_window:insert (board)
        
        
        
        local fontName = "Grinched"
        
        local txt=nil;
        local ox=0;
        if(thegame.GameLanguage=="rus") then
            fontName = "Basic Comical NC"
            txt="Настройки";
            ox=15;
        else
            txt="Settings";
        end

        local myText = display.newText(txt , 0, 0, fontName, 22)
        myText:setReferencePoint( display.TopCenterReferencePoint )
        myText.x=display.contentWidth*0.5-myText.width*0.5+ox;
        myText.y=16
        myText:setTextColor(255,255,255)
        settings_window:insert (myText) 
        
        
        
       
        createButtons()
        
        
        
        -- fade object to completely transparent and move the object as well
        AllTransition[#AllTransition+1]=transition.to( settings_window, { time=300, alpha=1.0, x=settings_window.x, y=0 } )
        AllTransition[#AllTransition+1]=transition.to( settings_window, {delay=300, time=100, alpha=1.0, x=settings_window.x, y=20 } )
        AllTransition[#AllTransition+1]=transition.to( settings_window, {delay=400, time=100, alpha=1.0, x=settings_window.x, y=-10 } )
        AllTransition[#AllTransition+1]=transition.to( settings_window, {delay=500, time=100, alpha=1.0, x=settings_window.x, y=0 } )


end


function onKeyEvent( event )

    if (event.phase == "up" and event.keyName=="back" ) then
        Runtime:removeEventListener( "key", onKeyEvent )
        BackEvent()
        return true;
    end
    return false;
end

function OpenSettingsForm(self)

    --buttons:removeAllButtons()

    DrawSettingsWindow()
    advertising:ShowAd()
    
    --add the runtime event listener
    if system.getInfo( "platformName" ) == "Android" then  
        Runtime:addEventListener( "key", onKeyEvent )
    end
end


