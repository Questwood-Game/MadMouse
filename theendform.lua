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
local theend_window=nil

local AllTransition={}

local function CancelAllTransition()
    for i=1, #AllTransition  do

        transition.cancel(AllTransition[i])
        AllTransition[i]=nil

    end
    i=nil
    AllTransition={}
end

function DrawTheendWindow(self)


        coverDesk = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDesk:setFillColor(0,0,0, 250)
        coverDesk:setReferencePoint( display.CenterCenterReferencePoint)
        coverDesk.x=display.contentWidth*0.5
        coverDesk.y=display.contentHeight*0.5--0
        coverDesk.alpha=0

        AllTransition[#AllTransition+1]=transition.to( coverDesk, { time=500, alpha=0.8 } )
                    
                        
	theend_window = display.newGroup();

        theend_window.width= 400
        theend_window.height= 300
        
	theend_window.x =display.contentWidth*0.5-200
	theend_window.y =-300-- 0-theend_window.height
        theend_window.alpha=1
        


        
        local board = display.newImageRect( "src/images/stages/theendstage.jpg",400,350 )
        --board:setFillColor(0,0,0, 0)
        board:setReferencePoint( display.TopLeftReferencePoint )
        board.x=0
        board.y=0
	theend_window:insert (board)

        --local onSimulator = system.getInfo( "environment" ) == "simulator"
        --local platformVersion = system.getInfo( "platformVersion" )
        --local olderVersion = tonumber(string.sub( platformVersion, 1, 1 )) < 4
        local fontName = "Grinched"
        local fontSize = 50

        local txt=nil;
        local ox=0;
        if(thegame.GameLanguage=="rus") then
            fontName = "Basic Comical NC"
            txt="Поздравляем!";
            ox=15;
        else
            txt="Congratulations!";
        end


        local myText = display.newText(txt, 0, 0, fontName, fontSize )
        
        myText.x=theend_window.width*0.5
        myText.y=68

        myText:setTextColor(20,0,0)
        theend_window:insert (myText) 

        local myText2 = display.newText(txt, 0, 0, fontName, fontSize )
        myText2.x=theend_window.width*0.5
        myText2.y=70
        myText2:setTextColor(255,200,0)
        myText2.alpha=0.5
        
        theend_window:insert (myText2) 
        
        
        -- fade object to completely transparent and move the object as well
        AllTransition[#AllTransition+1]=transition.to( theend_window, { time=300, alpha=1.0, x=theend_window.x, y=0 } )
        AllTransition[#AllTransition+1]=transition.to( theend_window, {delay=300, time=100, alpha=1.0, x=theend_window.x, y=20 } )
        AllTransition[#AllTransition+1]=transition.to( theend_window, {delay=400, time=100, alpha=1.0, x=theend_window.x, y=-10 } )
        AllTransition[#AllTransition+1]=transition.to( theend_window, {delay=500, time=100, alpha=1.0, x=theend_window.x, y=0 } )

        local tStep=100
        local startTime=300
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime, time=tStep,  x=theend_window.width*0.5, y=71 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*1, time=tStep,  x=theend_window.width*0.5+1, y=71 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*2, time=tStep, x=theend_window.width*0.5+1, y=69 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*3, time=tStep, x=theend_window.width*0.5-1, y=69 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*4, time=tStep, x=theend_window.width*0.5-1, y=70 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*5, time=tStep, x=theend_window.width*0.5, y=66 } )
        AllTransition[#AllTransition+1]=transition.to( myText2, {delay=startTime+tStep*6, time=tStep, alpha=1.0 } )

 
end


function createButtons(self)

    local c=200-25
    local y=220-25

    ButtonWebsite = widget.newButton{
        left=c-100,top=y-75,
	defaultFile = "src/images/buttons/button_info.png",
	overFile = "src/images/buttons/button_info.png",
	onRelease =Website,
        width=50,
        height=50
    }
    theend_window:insert (ButtonWebsite)

    ButtonMenu = widget.newButton{
        left=c-100,top=y,
	defaultFile = "src/images/buttons/button_menu.png",
	overFile = "src/images/buttons/button_menu.png",
	onRelease =Menu,
        width=50,
        height=50
    }
    theend_window:insert (ButtonMenu)

    
end

function Website(event)
    if event.phase == "ended" then
        CancelAllTransition()
        system.openURL( "http://www.madmousegame.com/index.php/congratulations" )
    end
end

local function doMenu()
        CancelAllTransition()
        advertising:HideAd();
        display.remove(coverDesk)
        coverDesk=nil
        display.remove(ButtonWebsite)
        ButtonWebsite=nil
        display.remove(ButtonMenu)
        ButtonMenu=nil
    
        display.remove(theend_window)
        theend_window=nil
        
        mainmenu:OpenMainMenu(false,false) 
end

function Menu(event)
    if event.phase == "ended" then
        doMenu()
   end
end

function onKeyEvent( event )
    local keyName = event.keyName;
    if (event.phase == "up" and (keyName=="back" or keyName=="menu")) then
            Runtime:removeEventListener( "key", onKeyEvent )
            doMenu()
            
            return true;
    end
    return false;
end

function TheEnd(self)

    DrawTheendWindow()

    createButtons()
    
    advertising:ShowAd()
    
    --add the runtime event listener
    if system.getInfo( "platformName" ) == "Android" then  
        Runtime:addEventListener( "key", onKeyEvent )
    end
end




