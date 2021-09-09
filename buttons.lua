--
-- Project: background.lua
-- Description: 
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 . All Rights Reserved.
-- 
module(..., package.seeall)


GameMode=1
-- 1 game
-- 0 editor
local TimerSet=false
------------------
local EditorButton=nil;
local ButtonPause = nil;
local ButtonMenu = nil;
local ButtonReplay = nil;
local ButtonCameraSwitch=nil
------------------
isGamePlaying=false

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




-- -------------------------------------------------------- Game Buttons
function CreateCameraButton()
        if ButtonCameraSwitch then
            display.remove(ButtonCameraSwitch)
            ButtonCameraSwitch=nil
        end
        
        local image=""
        if thegame.CameraWatch==1 then
            --girl
            image="src/images/buttons/button_girl.png"
        elseif thegame.CameraWatch==2 then
            --mouse
            image="src/images/buttons/button_mouse.png"
        else
            --trap
            image="src/images/buttons/button_trap.png"
        end
        
        ButtonCameraSwitch = widget.newButton{
            id="GirlButton",
            left=display.contentWidth-2-110,
            top=2,
            defaultFile = image,
            overFile = image,
            onRelease =SwitchCamera,
            width=50,
            height=50
        }
    
end


function createGameButtons(self)

    isGamePlaying=true

if system.getInfo( "environment" ) == "simulator" then
    
--[[
    EditorButton = widget.newButton{
        id="EditorButton",
        left=display.contentWidth-50-2-200,
        top=2,
        width=50,
        height=50,
	defaultFile = "src/images/buttons/button_50.png",
	overFile = "src/images/buttons/buttonOver_50.png",
	onRelease =Switch2Editor,
	label = "Edit"
    }
    --]]
end 

ButtonPause = widget.newButton{
	defaultFile = "src/images/buttons/button_pause.png",
	overFile = "src/images/buttons/button_pause.png",
	onRelease =Pause,
	width=50,
        height=50,
        left=display.contentWidth-2-50,
        top=2,
        id="PauseButton"
}


ButtonMenu = widget.newButton{
        id="MenuButton",
        left=2,
        top=2,
	defaultFile = "src/images/buttons/button_menu.png",
	overFile = "src/images/buttons/button_hover_menu.png",
	onRelease =Menu,
	width=50,
        height=50
}


CreateCameraButton()

ButtonReplay = widget.newButton{
        id="ReplayButton",
        left=62,
        top=2,
	defaultFile = "src/images/buttons/button_replay.png",
	overFile = "src/images/buttons/button_replay.png",
	onRelease =Replay,
	width=50,
        height=50
}

    TimerSet=false
end
     

function SwitchCamera(event)
    if event.phase == "ended" then
        --display.remove(ButtonMusic)
        --ButtonMusic=nil
        
        
        
        thegame.CameraWatch=thegame.CameraWatch+1
        if thegame.CameraWatch>3 then 
            thegame.CameraWatch=1
        end
        
        CreateCameraButton()
       
    end
end




local function StartGame()
    CancelAllTransition()
    thegame:setSkyDropListener()
    isGamePlaying=true
    if(thegame.BackGroundMusicChannel~=-1) then
        audio.resume(thegame.BackGroundMusicChannel)
    end
    
    physics_paused=false
    physics.start()
    
    --if(ButtonStart~=nil) then
    display.remove(ButtonStart)
    ButtonStart=nil
    --end
    
    ButtonPause = widget.newButton{
            id="PauseButton",
            left=display.contentWidth-2-50,
            top=2,
            defaultFile = "src/images/buttons/button_pause.png",
            overFile = "src/images/buttons/button_pause.png",
            onRelease =Pause,
            label = "",
            font=defaultFontName,
            width=50,
            height=50
    }
    
    CreateCameraButton()
    
    --if(coverDeskPause~=nil and coverDeskPause.x~=nil) then
    display.remove(coverDeskPause)
    coverDeskPause=nil
    --end
    
    --if(PauseText~=nil and PauseText.x~=nil) then
    display.remove(PauseText)
    PauseText=nil
    
    
    ButtonMenu.isVisible=true
    ButtonReplay.isVisible=true
    
    
end


function Start(event)
    if "ended" == event.phase then
        advertising:HideAd();
        StartGame()
    end
end

function PauseGame(useDelay)
        CancelAllTransition()
        thegame:removeSkyDropListener()
        isGamePlaying=false
    
        if(thegame.BackGroundMusicChannel~=-1) then
            audio.pause(thegame.BackGroundMusicChannel)
        end
    
        physics_paused=true
        physics.pause()
       
        if(ButtonPause~=nil) then
            display.remove(ButtonPause)
            ButtonPause=nil
        end
    
        if(ButtonCameraSwitch~=nil) then
            display.remove(ButtonCameraSwitch)
            ButtonCameraSwitch=nil
        end
       
        if(ButtonMenu~=nil) then
        ButtonMenu.isVisible=false
        end
        
        if(ButtonReplay~=nil) then
        ButtonReplay.isVisible=false
        end

     
        coverDeskPause = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
		coverDeskPause:setFillColor(0,0,0, 250)
        coverDeskPause.x=display.contentWidth*0.5
        coverDeskPause.y=display.contentHeight*0.5
        if useDelay then
            coverDeskPause.alpha=0
        else
            coverDeskPause.alpha=0.7
        end
 
        
        local fontName = "Grinched"
        local fontSize = 50
        local txt=nil;
        if(thegame.GameLanguage=="rus") then
            fontName = "Basic Comical NC"
            txt="ПАУЗА";
        else
            txt="PAUSE"
        end

        PauseText = display.newText(txt , 0, 0, fontName, fontSize )
		PauseText.anchorY = 0
        PauseText.x=display.contentWidth*0.5
        PauseText.y=display.contentHeight*0.5-PauseText.height*0.5-20
        PauseText:setTextColor(255,200,0)

        ButtonStart = widget.newButton{
            id="PlayButton",
            defaultFile = "src/images/buttons/button_play.png",
            overFile = "src/images/buttons/button_play.png",
            onRelease =Start,
            left=display.contentWidth*0.5-25,
            top=display.contentHeight*0.5+10,
            width=50,
            height=50
        }

        if useDelay then
            AllTransition[#AllTransition+1]=transition.to( coverDeskPause, { time=500, alpha=0.7 } )
            advertising:ShowAd()
        end
    
end

function Pause(event)
    local phase = event.phase 
    if "ended" == phase and not TimerSet  then
        PauseGame(true);
    end
end


function doQuit(event)
    if "ended" == event.phase then

        advertising:HideAd();
        os.exit();
    end
end

function doNotQuit(event)
    if "ended" == event.phase then

        advertising:HideAd();
        display.remove(ButtonQuitYes)
        ButtonQuitYes=nil
        
        display.remove(ButtonQuitNo)
        ButtonQuitNo=nil
        
        --if(QuitText~=nil and QuitText.x~=nil) then
            display.remove(QuitText)
            QuitText=nil
        --end
        
        --if(coverDeskQuit~=nil and coverDeskQuit.x~=nil) then
            display.remove(coverDeskQuit)
            coverDeskQuit=nil
        --end
        
        
        if mainmenu.isMainMenuOpen then
            mainmenu:ShowCoverButtons()
        else
            StartGame()
            enableKeyEvent_Main()
        end
    end
    
end


function QuitDialog(self)
        CancelAllTransition()
        --print ("Do you want to quit")
        
        if isGamePlaying then
            --Pause the game
            thegame:removeSkyDropListener()
            
            if(thegame.BackGroundMusicChannel~=-1) then
                audio.pause(thegame.BackGroundMusicChannel)
            end
    
            physics_paused=true
            physics.pause()
       
            if(ButtonPause~=nil) then
                display.remove(ButtonPause)
                ButtonPause=nil
            end
    
            if(ButtonCameraSwitch~=nil) then
                display.remove(ButtonCameraSwitch)
                ButtonCameraSwitch=nil
            end
       
            ButtonMenu.isVisible=false
            ButtonReplay.isVisible=false
            
            isGamePlaying=false
        end
        
        if mainmenu.isMainMenuOpen then
            print ("Hide Cover Buttons");
            mainmenu:HideCoverButtons()
        end
        
    
 
     
        coverDeskQuit = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
		coverDeskQuit:setFillColor(0,0,0, 250)
        coverDeskQuit.x=display.contentWidth*0.5
        coverDeskQuit.y=display.contentHeight*0.5
        coverDeskQuit.alpha=0
        
        
        local fontName = "Grinched"
        local fontSize = 36

        QuitText = display.newText( "Do you want to quit?", 0, 0, fontName, fontSize )
		QuitText.anchorY = 0
        QuitText.x=display.contentWidth*0.5
        QuitText.y=display.contentHeight*0.5-QuitText.height*0.5-40

        QuitText:setTextColor(255,200,0)
        
        local x=display.contentWidth*0.5-25
        local y=display.contentHeight*0.5+10
              
        ButtonQuitYes = widget.newButton{
            id="QuitYesButton",
            label="Yes",
            font=fontName,
            defaultFile = "src/images/buttons/button.png",
            overFile = "src/images/buttons/button_hover.png",
            onRelease =doQuit,
            left=x-50,
            top=y,
            width=50,
            height=50
        }

        ButtonQuitNo = widget.newButton{
            id="QuitNoButton",
            label="No",
            font=fontName,
            defaultFile = "src/images/buttons/button.png",
            overFile = "src/images/buttons/button_hover.png",
            onRelease =doNotQuit,
            left=x+50,
            top=y,
            width=50,
            height=50
        }


        AllTransition[#AllTransition+1]=transition.to( coverDeskQuit, { time=400, alpha=0.8 } )

end




function removeAllButtons()
        CancelAllTransition()
        isGamePlaying=false
    
        if(ButtonPause~=nil and ButtonPause.x~=nil) then
            display.remove( ButtonPause)
            ButtonPause=nil
        end
        
        if(ButtonStart~=nil and ButtonStart.x~=nil) then
            display.remove( ButtonStart)
            ButtonStart=nil
        end
        
        if(ButtonMenu~=nil) then
            display.remove( ButtonMenu)
            ButtonMenu=nil
        end

        if(ButtonReplay~=nil and ButtonReplay.x~=nil) then
            display.remove( ButtonReplay)
            ButtonReplay=nil
        end
        
        if(ButtonCameraSwitch~=nil and ButtonCameraSwitch.x~=nil) then
            display.remove( ButtonCameraSwitch)
            ButtonCameraSwitch=nil
        end
        
        
        
        
        if system.getInfo( "environment" ) == "simulator" then
            if(EditorButton ~=nil and EditorButton .x~=nil) then
                display.remove(EditorButton)
                EditorButton=nil
            end
        end 
        
end

function DoReplay(self)
        CancelAllTransition()
        removeAllButtons()
        thegame:Replay(true)
        
        --if(coverDeskReplay~=nil and coverDeskReplay.x~=nil) then
          --  display.remove(coverDeskReplay)
            --coverDeskReplay=nil
        --end
end

function Replay(event)
    if "ended" == event.phase and not TimerSet then
        Runtime:removeEventListener( "key", onKeyEvent_Main )
        thegame:removeSkyDropListener()
        TimerSet =true
        buttons.physics_paused=true
        physics.pause()
        
        ButtonReplay.isVisible=false
        removeAllButtons()
        
        
        
        world.StopWinLose()    

        DoReplay()

    end
end


local function doMenu()
        CancelAllTransition()
        if(thegame.BackGroundMusicChannel~=-1) then
            audio.pause(thegame.BackGroundMusicChannel)
        end
    

    
        --if(coverDeskPause~=nil and coverDeskPause.x~=nil) then
        display.remove(coverDeskPause)
        coverDeskPause=nil
        --end
        

        
        mainmenu:OpenMainMenu(true,false)
   
end
function MenuEvent()
    CancelAllTransition()
    Runtime:removeEventListener( "key", onKeyEvent_Main )
    thegame:removeSkyDropListener()
    removeAllButtons()
    TimerSet = true
        
    Timers[#Timers]=timer.performWithDelay( 10, doMenu, 1 )    
end

function Menu(event)
    
    if event.phase == "ended" and not TimerSet then
        MenuEvent()
    end
end

-- -------------------------------------------------------------------------------- Game Functions

function Switch2Editor(event)
    if "ended" == event.phase then
        buttons:QuitDialog();
        --[[
	--if(EditorButton) then
            display.remove(EditorButton)
            EditorButton=nil
        --end
	
	GameMode=0
	local editor = require( "editor" )
	editor:createEditorButtons()
        
        ]]--
   end
	
end

