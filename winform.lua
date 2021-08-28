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

local coverDesk=nil
local coverDesk2=nil
local coverDesk3=nil
local winner_window=nil

local Timers={}

local AllTransition={}

local function CancelAllTransition()
    for i=1, #AllTransition  do

        transition.cancel(AllTransition[i])
        AllTransition[i]=nil

    end
    i=nil
    AllTransition={}
end

local function cancelTimers()
    for i=1, #Timers do
            timer.cancel( Timers[i] ) 
            Timers[i]=nil
    end
    Timers={}
end


local function DisableGame(self)
    
    buttons.physics_paused=true
    physics.pause()

end


function DrawWinnerWindow(self)


        coverDesk = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDesk:setFillColor(0,0,0, 250)
        coverDesk:setReferencePoint( display.CenterCenterReferencePoint)
        coverDesk.x=display.contentWidth*0.5
        coverDesk.y=display.contentHeight*0.5--0
        coverDesk.alpha=0

        AllTransition[#AllTransition+1]=transition.to( coverDesk, { time=500, alpha=0.8 } )
                    
                        
	winner_window = display.newGroup();

        winner_window.width= 400
        winner_window.height= 300
        
	winner_window.x =display.contentWidth*0.5-200
	winner_window.y =-300-- 0-winner_window.height
        winner_window.alpha=1
        


        
        local board = display.newImageRect( "src/images/stages/stage.jpg",400,350 )

        board:setReferencePoint( display.TopLeftReferencePoint )
        board.x=0
        board.y=0
	winner_window:insert (board)


        local onSimulator = system.getInfo( "environment" ) == "simulator"
        local platformVersion = system.getInfo( "platformVersion" )
        local olderVersion = tonumber(string.sub( platformVersion, 1, 1 )) < 4
        local fontName = "Grinched"
        local fontSize = 50


        local txt=nil;
        local ox=0;
        if(thegame.GameLanguage=="rus") then
            fontName = "Basic Comical NC"
            txt="Мышь в ловушке!";
            fontSize=36
            ox=10;
        else
            txt="Mouse in Trap!";
        end

        local myText = display.newText( txt, 0, 0, fontName, fontSize )
        
        myText.x=winner_window.width*0.5
        myText.y=68

        myText:setTextColor(20,0,0)
        winner_window:insert (myText) 

        local myText2 = display.newText( txt, 0, 0, fontName, fontSize )
        myText2.x=winner_window.width*0.5+ox
        myText2.y=70
        myText2:setTextColor(255,200,0)
        myText2.alpha=0.5
        
        winner_window:insert (myText2) 
        
        
        -- fade object to completely transparent and move the object as well
        AllTransition[#AllTransition+1]=transition.to( winner_window, { time=300, alpha=1.0, x=winner_window.x, y=0 } )
        AllTransition[#AllTransition+1]=transition.to( winner_window, {delay=300, time=100, alpha=1.0, x=winner_window.x, y=20 } )
        AllTransition[#AllTransition+1]=transition.to( winner_window, {delay=400, time=100, alpha=1.0, x=winner_window.x, y=-10 } )
        AllTransition[#AllTransition+1]=transition.to( winner_window, {delay=500, time=100, alpha=1.0, x=winner_window.x, y=0 } )

        local tStep=100
        local startTime=300
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime, time=tStep,  x=winner_window.width*0.5, y=71 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*1, time=tStep,  x=winner_window.width*0.5+1, y=71 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*2, time=tStep, x=winner_window.width*0.5+1, y=69 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*3, time=tStep, x=winner_window.width*0.5-1, y=69 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*4, time=tStep, x=winner_window.width*0.5-1, y=70 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*5, time=tStep, x=winner_window.width*0.5, y=66 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*6, time=tStep, alpha=1.0 } )

 
end


function DrawGoldenFaces(self)
        
              
        local NumberOfStars=math.floor(3*1/world.NumberOfItems*(world.NumberOfItems-world.NumberOfItemsUsed))+1

        
        local tStep=100
        local startTime=300

        local goldenfacegrey1 = display.newImageRect( "src/images/medals/golden_face_grey.png",98,84 )
        local gfw=goldenfacegrey1.width*0.5
        local gfx=winner_window.width*0.5-gfw

        goldenfacegrey1:setReferencePoint( display.TopLeftReferencePoint )
        goldenfacegrey1.x=gfx-gfw*1.9
        goldenfacegrey1.y=100
        winner_window:insert (goldenfacegrey1)
        
        local goldenfacegrey2 = display.newImageRect( "src/images/medals/golden_face_grey.png",98,84 )
        goldenfacegrey2:setReferencePoint( display.TopLeftReferencePoint )
        goldenfacegrey2.x=gfx
        goldenfacegrey2.y=100
        winner_window:insert (goldenfacegrey2)
        
        local goldenfacegrey3 = display.newImageRect( "src/images/medals/golden_face_grey.png",98,84 )
        goldenfacegrey3:setReferencePoint( display.TopLeftReferencePoint )
        goldenfacegrey3.x=gfx+gfw*1.9
        goldenfacegrey3.y=100
        winner_window:insert (goldenfacegrey3)
        
            
        if(NumberOfStars>0) then
            local goldenface1 = display.newImageRect( "src/images/medals/golden_face.png",98,84 )            
            goldenface1:setReferencePoint( display.TopLeftReferencePoint )
            goldenface1.x=gfx-1000
            goldenface1.y=-100
            goldenface1.alpha=0.5
            winner_window:insert (goldenface1)
            AllTransition[#AllTransition+1]=transition.to( goldenface1, {delay=startTime+tStep*5, time=tStep*3, x=gfx-gfw*1.9, y=100, alpha=1.0 } )

            if(thegame.PlaySound) then
            
                
                local myclosure= function()
                    local availableChannel = audio.findFreeChannel()
                    audio.setVolume(1, { channel=availableChannel } )
                    audio.play( thegame.bodyFlySounds[1], { channel=availableChannel } )
                end
                Timers[#Timers+1]=timer.performWithDelay(1000,myclosure,1)
            end
        end
                
        if(NumberOfStars>1) then
            local goldenface2 = display.newImageRect( "src/images/medals/golden_face.png",98,84 )
            goldenface2:setReferencePoint( display.TopLeftReferencePoint )
            goldenface2.x=gfx
            goldenface2.y=-300
            goldenface2.alpha=0.5
            winner_window:insert (goldenface2)
            AllTransition[#AllTransition+1]=transition.to( goldenface2, {delay=startTime+tStep*10, time=tStep*3, x=gfx, y=100, alpha=1.0 } )

            
            local myclosure= function()
                local availableChannel = audio.findFreeChannel()
                audio.setVolume(1, { channel=availableChannel } )
                audio.play( thegame.bodyFlySounds[1], { channel=availableChannel } )
            end
            Timers[#Timers+1]=timer.performWithDelay(1500,myclosure,1)
        end

        if(NumberOfStars>2) then
            local goldenface3 = display.newImageRect( "src/images/medals/golden_face.png",98,84 )
            goldenface3:setReferencePoint( display.TopLeftReferencePoint )
            goldenface3.x=gfx+1000
            goldenface3.y=-100
            goldenface3.alpha=0.5
            winner_window:insert (goldenface3)
            AllTransition[#AllTransition+1]=transition.to( goldenface3, {delay=startTime+tStep*15, time=tStep*3, x=gfx+gfw*1.9, y=100, alpha=1.0 } )

            
            local myclosure= function()
                local availableChannel = audio.findFreeChannel()
                audio.setVolume(1, { channel=availableChannel } )
                audio.play( thegame.bodyFlySounds[1], { channel=availableChannel } )
            end
            Timers[#Timers+1]=timer.performWithDelay(2000,myclosure,1)
        end

end

function createButtons(self)

    local c=200-25
    local y=220-25

    ButtonMenu = widget.newButton{
        left=c-75,top=y,
	defaultFile = "src/images/buttons/button_menu.png",
	overFile = "src/images/buttons/button_menu.png",
	onRelease =Menu,
        width=50,
        height=50
    }
    winner_window:insert (ButtonMenu)
    --ButtonMenu:setReferencePoint( display.CenterLeftReferencePoint )
    --ButtonMenu.x =c-ButtonMenu.width*1.5
    --ButtonMenu.y =y

    ButtonReplay = widget.newButton{
        left=c,top=y,
	defaultFile = "src/images/buttons/button_replay.png",
	overFile = "src/images/buttons/button_replay.png",
	onRelease =Replay,
	width=50,
        height=50
    }
    winner_window:insert (ButtonReplay)

    
        ButtonNext = widget.newButton{
            left=c+75,top=y,
            defaultFile = "src/images/buttons/button_next.png",
            overFile = "src/images/buttons/button_next.png",
            onRelease =Next,
            width=50,
            height=50
        }
        winner_window:insert (ButtonNext)
    
end



function DoReplay(self)
    CancelAllTransition()
    
    cancelTimers()
    
    advertising:HideAd();
    --if (coverDesk~=nil and coverDesk.x~=nil ) then
    --if coverDesk then
        display.remove(coverDesk)
        coverDesk=nil
    --end
    
    --if coverDesk2 then
        display.remove(coverDesk2)
        coverDesk2=nil
    --end
    
    display.remove(ButtonReset)
    ButtonReset=nil
    
    display.remove(ButtonMenu)
    ButtonMenu=nil
    
    --if ButtonNext then
        display.remove(ButtonNext)
        ButtonNext=nil
    --end
    
    display.remove(winner_window)
    winner_window=nil
    

    thegame:Replay(true)
    
    display.remove(Loading)
    Loading=nil
end

function DoNext(self)
    cancelTimers()
    CancelAllTransition()
    
    advertising:HideAd();
    thegame.CurrentLevel=thegame.CurrentLevel+1
    
    local userstate = ice:loadBox( "userstate" )
    userstate:store( "currentlevel", thegame.CurrentLevel )
    userstate:save()

    display.remove(coverDesk)
    coverDesk=nil
    
    display.remove(coverDesk3)
    coverDesk3=nil
    
    display.remove(ButtonReset)
    ButtonReset=nil
    
    display.remove(ButtonMenu)
    ButtonMenu=nil
    
    if ButtonNext then
        display.remove(ButtonNext)
        ButtonNext=nil
    end
    
    display.remove(winner_window)
    winner_window=nil


    if(thegame.CurrentLevel<=levels.NumberOfLevels) then
        thegame:Replay(true)
    else
        theendform.TheEnd()
    end
    
    display.remove(Loading)
    Loading=nil
end

local function ReplayEvent()
        
        coverDesk2 = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDesk2:setFillColor(0,0,0, 250)
        coverDesk2:setReferencePoint( display.TopCenterReferencePoint)
        coverDesk2.x=display.contentWidth*0.5
        coverDesk2.y=0
        coverDesk2.alpha=0
        AllTransition[#AllTransition+1]=transition.to( coverDesk2, { time=200, alpha=0.9 } )
        Timers[#Timers+1]=timer.performWithDelay(200,DoReplay,1)
end

function Replay(event)
    if event.phase == "ended" then
        Runtime:removeEventListener( "key", onKeyEvent )
        ReplayEvent()
    end
end

function Next(event)
   if event.phase == "ended" then
        Runtime:removeEventListener( "key", onKeyEvent )
        
        coverDesk3 = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDesk3:setFillColor(0,0,0, 250)
        coverDesk3:setReferencePoint( display.TopCenterReferencePoint)
        coverDesk3.x=display.contentWidth*0.5
        coverDesk3.y=0
        coverDesk3.alpha=0
        AllTransition[#AllTransition+1]=transition.to( coverDesk3, { time=200, alpha=0.9 } )
        Timers[#Timers+1]=timer.performWithDelay(200,DoNext,1)
        
  
                
   end
end

local function doMenu()
        CancelAllTransition()
        cancelTimers()
        
        advertising:HideAd();
        
        display.remove(coverDesk)
        coverDesk=nil
    
        display.remove(ButtonReset)
        ButtonReset=nil
        display.remove(ButtonMenu)
        ButtonMenu=nil
    
        if ButtonNext then
            display.remove(ButtonNext)
            ButtonNext=nil
        end
        display.remove(winner_window)
        winner_window=nil
        mainmenu:OpenMainMenu(false,false)
end

function Menu(event)
    if event.phase == "ended" then
        Runtime:removeEventListener( "key", onKeyEvent )
        doMenu()
   end
end

function onKeyEvent( event )
    local keyName = event.keyName;
    if (event.phase == "up" and (keyName=="back" or keyName=="menu")) then
            Runtime:removeEventListener( "key", onKeyEvent )
            
            if keyName=="menu" then
                doMenu()
            else
                ReplayEvent()
            end
            return true;
    end
    return false;
end


function Won(self)
    Runtime:removeEventListener( "key", onKeyEvent_Main )   
    if(thegame.BackGroundMusicChannel~=-1) then
        audio.stop(thegame.BackGroundMusicChannel)
    end

    if(thegame.MaxLevel<=thegame.CurrentLevel+1) then
        thegame.MaxLevel=thegame.CurrentLevel+1
        
            local userstate = ice:loadBox( "userstate" )
            userstate:store( "maxlevel", thegame.MaxLevel )
            userstate:save()
    
    end
    
    buttons:removeAllButtons()
    DisableGame()
    DrawWinnerWindow()
    DrawGoldenFaces()
    createButtons()
    
    advertising:ShowAd()
    
    --add the runtime event listener
    if system.getInfo( "platformName" ) == "Android" then  
        Runtime:addEventListener( "key", onKeyEvent )
    end
end
