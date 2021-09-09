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

local CoverButtons={}

local showQuitButton=false;
isMainMenuOpen=false

local coverDesk=nil
local coverDesk2=nil
local coverDesk_Reset=nil
local mainmenu_window=nil

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

local function DisableGame(self)
    

    buttons.physics_paused=true
    physics.pause()

end

local function typeVersion()
        

        local QuitText = display.newText( "v.1.1.2", 0, 0, "Grinched", 10 )
        --QuitText:setReferencePoint( display.TopCenterReferencePoint)
        QuitText.x=175
        QuitText.y=96

        QuitText:setTextColor(40,40,40,100)
        mainmenu_window:insert (QuitText)
        
end

local function drawCovers(nextButtonInCenter)
    CoverButtons={}
    local Covers="level_1_thumb_cover.png,200,52;level_2_thumb_cover.jpg,200,112;"
    Covers=Covers.."level_3_thumb_cover.jpg,126,112;level_4_thumb_cover.jpg,46,112;"
    Covers=Covers.."level_5_thumb_cover.jpg,266,112;level_6_thumb_cover.jpg,346,112;"
    Covers=Covers.."level_7_thumb_cover.jpg,280,168;level_8_thumb_cover.jpg,140,168;"
    Covers=Covers.."level_9_thumb_cover.jpg,58,168;level_10_thumb_cover.jpg,201,222;"
    Covers=Covers.."level_11_thumb_cover.jpg,148,222;level_12_thumb_cover.jpg,254,222;"
    
    local CoversVars = str.split(Covers, ";")
    local xh=-200
    local yh=-108
    

    
    for i = 1, #CoversVars do
        
        local onevalue = str.split(CoversVars[i], ",")
        if(#onevalue>1) then
            
        
        if i>=thegame.MaxLevel then
            
            if(i==thegame.MaxLevel) and i<=levels.NumberOfLevels and nextButtonInCenter==false then
                
                local image="";
                --i<thegame.MaxLevel or 
                if(i>=thegame.CurrentLevel) then
                    image="src/images/buttons/button_replay_small.png"
                else
                    image="src/images/buttons/button_next_small.png"
                end
                
                CoverButtons[#CoverButtons+1] = widget.newButton{
                    id="Cover"..#CoverButtons,
                    left=onevalue[2]+xh-16,
                    top=onevalue[3]+yh-16,
                    defaultFile = image,
                    overFile = image,
                    onRelease =PlayLevel,
                    width=32,
                    height=32
                }
                mainmenu_window:insert (CoverButtons[#CoverButtons])
                --ButtonLevel:setFillColor(0,0,0,120)
                --CoverButtons[#CoverButtons].x =onevalue[2]+xh
                --CoverButtons[#CoverButtons].y =onevalue[3]+yh
                CoverButtons[#CoverButtons].level=i
                --ButtonLevel.alpha=0.5
            else
                local b = display.newImage("src/images/levels/"..onevalue[1] )
                b.x=onevalue[2]+xh
                b.y=onevalue[3]+yh
                mainmenu_window:insert (b)
            end
            
           
            
            if(i>thegame.MaxLevel or i>levels.NumberOfLevels) then
                if(i<=levels.NumberOfLevels) then
                    local c = display.newImageRect( "src/images/misc/lock.png",31,40)
                    c.x=onevalue[2]+xh
                    c.y=onevalue[3]+yh
                    mainmenu_window:insert (c)
                else
                    local c = display.newImageRect( "src/images/misc/lock-unavailable.png",31,40)
                    c.x=onevalue[2]+xh
                    c.y=onevalue[3]+yh
                    mainmenu_window:insert (c)
                end
                
               
           end
       else
            local image="src/images/buttons/button_replay_small.png"
                
            --if(i==thegame.CurrentLevel) then
              --  image="src/images/buttons/button_replay_small.png"
            --end
                
            CoverButtons[#CoverButtons+1] = widget.newButton{
                id="Cover"..#CoverButtons,
                left=onevalue[2]+xh-16,
                top=onevalue[3]+yh-16,
                defaultFile = image,
                overFile = image,
                onRelease =PlayLevel,
                width=32,
                height=32
            }
            mainmenu_window:insert (CoverButtons[#CoverButtons])
            --CoverButtons[#CoverButtons].x =onevalue[2]+xh
            --CoverButtons[#CoverButtons].y =onevalue[3]+yh
            CoverButtons[#CoverButtons].level=i

        end
        end --if(#onevalue>1) then
    end

end

local function DrawMainMenuWindow(nextButtonInCenter)


        coverDesk = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDesk:setFillColor(0,0,0, 250)
        --coverDesk:setReferencePoint( display.CenterCenterReferencePoint)
        coverDesk.x=display.contentWidth*0.5
        coverDesk.y=display.contentHeight*0.5
        coverDesk.alpha=0
	--game:insert (coverDesk)
        AllTransition[#AllTransition+1]=transition.to( coverDesk, { time=500, alpha=0.8 } )
                    
                        
	mainmenu_window = display.newGroup();

        local yh=160
        
        mainmenu_window.width= 600
        mainmenu_window.height= 320
        --mainmenu_window:setReferencePoint( display.TopCenterReferencePoint )
	mainmenu_window.x =display.contentWidth*0.5---320
	mainmenu_window.y =160---300
        mainmenu_window.alpha=0
                      
       
       
        local is3x4=""; 
        local h=320
        if(display.pixelHeight==1024 and display.pixelWidth==768) then            is3x4="_3x4"; h=384; end;
        if(display.pixelHeight==2048 and display.pixelWidth==1536) then            is3x4="_3x4";h=384;  end;
        
        print("is3x4="..is3x4)
        
        local board_image=""
        if levels.NumberOfLevels==8 then 
            board_image="level_selection_lite.jpg"
        else
            if(thegame.GameLanguage=="rus") then
                board_image="level_selection_rus"..is3x4..".jpg"
            else
                board_image="level_selection"..is3x4..".jpg"
            end
        end
        
        
        local board = display.newImageRect( "src/images/levels/"..board_image,600, h)
        --board:setFillColor(0,0,0, 0)
        --board:setReferencePoint( display.TopLeftReferencePoint )
        board.x=0
        board.y=0
	mainmenu_window:insert (board)
        
        
        drawCovers(nextButtonInCenter)
        
        
        
        -- fade object to completely transparent and move the object as well
        AllTransition[#AllTransition+1]=transition.to( mainmenu_window, { time=300, alpha=1.0 } )
        
end


local function createButtons(playButton,nextButtonInCenter)

    local c=200-25
    local y=mainmenu_window.height-10

    if playButton then
        ButtonPlay = widget.newButton{
            id="PlayButton",
            left=display.contentWidth*0.5-2-50,
            top=-display.contentHeight*0.5+2,
            defaultFile = "src/images/buttons/button_play.png",
            overFile = "src/images/buttons/button_play.png",
            onRelease =Play,
            width=50,
            height=50,
        }
        mainmenu_window:insert (ButtonPlay)
   else
            
        if(thegame.CurrentLevel<levels.NumberOfLevels) then
        --It was NOT the last level
            local x,y
            if nextButtonInCenter then
                x=0-25--display.contentWidth*0.5-25
                y=0+10--display.contentHeight*0.5-25
            else
                x = display.contentWidth*0.5-2-50
                y = -display.contentHeight*0.5+2
            end
    
            ButtonNext = widget.newButton{
                id="NextButton",left=x,top=y,
                defaultFile = "src/images/buttons/button_next.png",
                overFile = "src/images/buttons/button_next.png",
                onRelease =Next,
                width=50,
                height=50,
            }
            mainmenu_window:insert (ButtonNext)
            
            

        end
            
    end

    


    
    if showQuitButton~=true then
    
        ButtonSettings = widget.newButton{
            id="SettingsButton",left=display.contentWidth*0.5-2-50,top=display.contentHeight*0.5-2-50,
            defaultFile = "src/images/buttons/button_settings.png",
            overFile = "src/images/buttons/button_settings.png",
            onRelease =Settings,
            width=50,
            height=50,
            label = ""
        }

        mainmenu_window:insert (ButtonSettings);
        
    else
            
        ButtonQuit = widget.newButton{
            id="QuitButton",left=display.contentWidth*0.5-2-50,top=display.contentHeight*0.5-2-50,
            defaultFile = "src/images/buttons/button_quit.png",
            overFile = "src/images/buttons/button_quit.png",
            onRelease =Quit,
            width=50,
            height=50,
        }
        mainmenu_window:insert (ButtonQuit)
            
            ButtonSettings = widget.newButton{
            id="SettingsButton",left=display.contentWidth*0.5-2-110,top=display.contentHeight*0.5-2-50,
            defaultFile = "src/images/buttons/button_settings.png",
            overFile = "src/images/buttons/button_settings.png",
            onRelease =Settings,
            width=50,
            height=50,
            label = ""
        }
        mainmenu_window:insert (ButtonSettings);
    end
    
    
    

    
    ButtonInfo = widget.newButton{
            id="InfoButton",left=-display.contentWidth*0.5+2,top=display.contentHeight*0.5-2-50,
            defaultFile = "src/images/buttons/button_info.png",
            overFile = "src/images/buttons/button_info.png",
            onRelease =Info,
            width=50,
            height=50,
        }
    mainmenu_window:insert (ButtonInfo)

    
end

function HideCoverButtons(self)
   for i=1, #CoverButtons do
       CoverButtons[i].isVisible=false
   end
   
   if ButtonPlay then
        ButtonPlay.isVisible=false
   end
   
   if ButtonNext then
        ButtonNext.isVisible=false
   end
   
   if showQuitButton then
        ButtonQuit.isVisible=false
   end
    
    
   ButtonSettings.isVisible=false
   ButtonInfo.isVisible=false
       
end

function ShowCoverButtons(self)
   for i=1, #CoverButtons do
       CoverButtons[i].isVisible=true
   end
   
   if ButtonPlay then
        ButtonPlay.isVisible=true
   end
   
   if ButtonNext then
        ButtonNext.isVisible=true
   end
   
   if showQuitButton then
    ButtonQuit.isVisible=true
   end
    
   ButtonSettings.isVisible=true
   ButtonInfo.isVisible=true
   
   
    if system.getInfo( "platformName" ) == "Android" then  
        Runtime:addEventListener( "key", onKeyEvent )
    end
    
    
    --collectgarbage()
    --print( "MemUsage: " .. collectgarbage("count") )
    --local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
    --print( "TexMem:   " .. textMem )
end

local function removeButtons()
    
    if ButtonNext then
        display.remove(ButtonNext)
        ButtonNext=nil
    end
    
    if ButtonPlay then
        display.remove(ButtonPlay)
        ButtonPlay=nil
    end
   
   display.remove(ButtonSettings)
   ButtonSettings=nil
        
   display.remove(ButtonInfo)
   ButtonInfo=nil
        
   if showQuitButton then
    display.remove(ButtonQuit)
    ButtonQuit=nil
   end
   
   
    for i=1, #CoverButtons do
        CoverButtons[i].isVisible=false
        display.remove(CoverButtons[i])
        CoverButtons[i]=nil
   end
   CoverButtons=nil
end

function DoReplay(self)
    display.remove(coverDesk)
    coverDesk=nil
    display.remove(coverDesk2)
    coverDesk2=nil
    
    CancelAllTransition()
    display.remove(mainmenu_window)
    mainmenu_window=nil
    
    thegame:Replay(true)
    display.remove(Loading)
    Loading=nil
end

function DoPlay(self)
    isMainMenuOpen=false
    
    if(thegame.BackGroundMusicChannel~=-1) then
        audio.resume(thegame.BackGroundMusicChannel)
    end
    
    
    display.remove(coverDesk2)
    coverDesk2=nil
    
    removeButtons()
    
    CancelAllTransition()
    display.remove(mainmenu_window)
    mainmenu_window=nil
    
    buttons:createGameButtons()
    

    buttons.physics_paused=false;
    physics.start()
    thegame:setSkyDropListener()
    enableKeyEvent_Main()
    
    if levels.ShowAds then
        advertising:ShowAd()
    end
    
end


function DoNext(self)
    isMainMenuOpen=false
    if(coverDesk)then
        
        display.remove(coverDesk)
        coverDesk=nil
    end
    if(coverDesk3)then
        display.remove(coverDesk3)
        coverDesk3=nil
    end
    
    CancelAllTransition()
    display.remove(mainmenu_window)
    mainmenu_window=nil

    thegame:Replay(true)
    
    display.remove(Loading)
    Loading=nil
end

function Replay(event)
    if event.phase == "ended" then
        Runtime:removeEventListener( "key", onKeyEvent )
        
        removeButtons()
        coverDesk2 = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDesk2:setFillColor(0,0,0, 250)
        coverDesk2:setReferencePoint( display.TopCenterReferencePoint)
        coverDesk2.x=display.contentWidth*0.5
        coverDesk2.y=0
        coverDesk2.alpha=0
	--game:insert (coverDesk)
        AllTransition[#AllTransition+1]=transition.to( coverDesk2, { time=200, alpha=0.9 } )
       
        Timers[#Timers]=timer.performWithDelay(200,DoReplay,1)
        

    end
end

function Play(event)
   if event.phase == "ended" then
        Runtime:removeEventListener( "key", onKeyEvent )
        
        AllTransition[#AllTransition+1]=transition.to( coverDesk, { time=200, alpha=0 } )
        Timers[#Timers]=timer.performWithDelay(200,DoPlay,1)
   end
        
end

function PlayLevel(event)
   if event.phase == "ended" then
        Runtime:removeEventListener( "key", onKeyEvent )
        removeButtons()
        thegame.CurrentLevel=event.target.level
        
        local userstate = ice:loadBox( "userstate" )
        userstate:store( "currentlevel", thegame.CurrentLevel )
        userstate:save()

        
        coverDesk3 = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDesk3:setFillColor(0,0,0, 250)
        --coverDesk3:setReferencePoint( display.TopCenterReferencePoint)
        coverDesk3.x=display.contentWidth*0.5
        coverDesk3.y=0
        coverDesk3.alpha=0
        AllTransition[#AllTransition+1]=transition.to( coverDesk3, { time=200, alpha=0.9 } )
       
        Timers[#Timers]=timer.performWithDelay(200,DoNext,1)
        
        

   end
end


function Next(event)
    if event.phase == "ended" then
        Runtime:removeEventListener( "key", onKeyEvent )

        
        removeButtons()
        thegame.CurrentLevel=thegame.CurrentLevel+1
        
        local userstate = ice:loadBox( "userstate" )
        userstate:store( "currentlevel", thegame.CurrentLevel )
        userstate:save()

    
        coverDesk3 = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDesk3:setFillColor(0,0,0, 250)
        --coverDesk3:setReferencePoint( display.TopCenterReferencePoint)
        coverDesk3.x=display.contentWidth*0.5
        coverDesk3.y=0
        coverDesk3.alpha=0
        AllTransition[#AllTransition+1]=transition.to( coverDesk3, { time=200, alpha=0.9 } )
       
        Timers[#Timers]=timer.performWithDelay(200,DoNext,1)

        
   end
end

function Quit(event)
    if event.phase == "ended" then
        CancelAllTransition()
        Runtime:removeEventListener( "key", onKeyEvent )
        buttons:QuitDialog();
        --os.exit();
    end

end

function Settings(event)
    if event.phase == "ended" then
        CancelAllTransition()
        Runtime:removeEventListener( "key", onKeyEvent )
        HideCoverButtons()
        settingsform:OpenSettingsForm()
    end
end

function Info(event)
    if event.phase == "ended" then
        CancelAllTransition()
        Runtime:removeEventListener( "key", onKeyEvent )
        HideCoverButtons()
        helpform:OpenHelpForm()
    end
end



function onKeyEvent( event )
    
    if (event.phase == "up" and event.keyName=="back" ) then


            Runtime:removeEventListener( "key", onKeyEvent )
            if ButtonPlay~=nil and ButtonPlay.x~=nil then
                -- the game was paused
                -- resume it
                AllTransition[#AllTransition+1]=transition.to( coverDesk, { time=200, alpha=0 } )
                Timers[#Timers]=timer.performWithDelay(200,DoPlay,1)
                
                
            else
                buttons:QuitDialog();
            end
            return true;
    end
    return false;
end


function OpenMainMenu(self, playButton,nextButtonInCenter)


    advertising:HideAd();
    buttons:removeAllButtons()
    DisableGame()
    isMainMenuOpen=true
    DrawMainMenuWindow(nextButtonInCenter)
    createButtons(playButton,nextButtonInCenter)
    typeVersion()
    
    if system.getInfo( "platformName" ) == "Android" then  
        Runtime:addEventListener( "key", onKeyEvent )
    end
    
    collectgarbage()
    print( "MemUsage: " .. collectgarbage("count") )
    local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
    print( "TexMem:   " .. textMem )
end


function DoReset()

    display.remove(coverDesk)
    coverDesk=nil
    
    display.remove(coverDesk_Reset)
    coverDesk_Reset=nil
    
    
    if ButtonNext~=nil and ButtonNext.x~=nil then
        display.remove(ButtonNext)
        ButtonNext=nil
    end
    
    
    if ButtonNext~=nil and ButtonQuit.x~=nil then
        display.remove(ButtonQuit)
        ButtonQuit=nil
    end
    
    

    display.remove(mainmenu_window)
    mainmenu_window=nil
    
    --buttons:removeAllButtons()
    --DisableGame()
    --thegame:Replay(false)
    isMainMenuOpen=true
    DrawMainMenuWindow(true)
    createButtons(false,true)

end    
function ResetTheGame(self)

    advertising:HideAd();
    coverDesk_Reset = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
    coverDesk_Reset:setFillColor(0,0,0, 250)
    coverDesk_Reset:setReferencePoint( display.TopCenterReferencePoint)
    coverDesk_Reset.x=display.contentWidth*0.5
    coverDesk_Reset.y=0
    coverDesk_Reset.alpha=0
    AllTransition[#AllTransition+1]=transition.to( coverDesk_Reset, { time=200, alpha=0.9 } )

    Timers[#Timers]=timer.performWithDelay(200,DoReset,1)

    
    
end
