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

local help_window=nil
local coverDeskHelp=nil
local AllTransition={}

local Timers={}
function EraseAllTimers()
    for i=1, #Timers do
            timer.cancel( Timers[i] ) 
            Timers[i]=nil
    end
    Timers={}
end

local function CancelAllTransition()
    EraseAllTimers()
    for i=1, #AllTransition  do

        transition.cancel(AllTransition[i])
        AllTransition[i]=nil

    end
    i=nil
    AllTransition={}
end
local function createButtons(self)

    ButtonBack = widget.newButton{
            id="HelpButton",left=-238,top=2,
            defaultFile = "src/images/buttons/button_back.png",
            overFile = "src/images/buttons/button_hover_back.png",
            onRelease =Back,
            width=50,
            height=50
    }

    help_window:insert (ButtonBack)
           
end
    
    
local function DrawHelpWindow(self)

    coverDeskHelp = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
	coverDeskHelp:setFillColor(0,0,0, 250)
    coverDeskHelp.x=display.contentWidth*0.5
    coverDeskHelp.y=display.contentHeight*0.5
    coverDeskHelp.alpha=0
        
	help_window = display.newGroup();

    help_window.width= 400
    help_window.height= 300

	help_window.x =display.contentWidth*0.5---help_window.width*0.5
	help_window.y =0
    help_window.alpha=1
        
    createButtons()
        
    local fontName = "Grinched";

    local gameDescription={};

--[[
local fonts = native.getFontNames()
local name = "basic"     -- part of the Font name we are looking for

name = string.lower( name )

for i, fontname in ipairs(fonts) do
     j, k = string.find( string.lower( fontname ), name )

    if( j ~= nil ) then

        print( "fontname = " .. tostring( fontname ) )

    end
end
--]]
        local DescHeight=nil;
        local Colors=nil;
        local FontSize=nil;

        if(thegame.GameLanguage=="rus") then
            fontName = "Basic Comical NC"
            
            
            gameDescription[1]="Мышь в доме"    
            
            gameDescription[2]="Вы играете за маленькую девочку, которая пытается загнать мышь в ловушку.";
        
            gameDescription[3]="Весь дом в вашем распоряжении. Девочка подбирает вещи до которых может дотянутся, например: книги, бутылки, мячи и.т.д. и кидает их в мышь.";
        
            gameDescription[4]="С каждым уровнем мышь становиться все умнее и умнее, со временем он начнет боятся ловушки и будет действительно сложно его туга загнать.";
            gameDescription[5]="Вы можете использовать сыр, чтобы заманить мышь в ловушку. Но если мышь съест сыр он сможет выше прыгать.";
            gameDescription[6]="Если мышь дотронется до девочки, то вы проиграете.";
            
    
            gameDescription[7]="Автор:";
            gameDescription[8]="Иван Комлев";
        
            gameDescription[9]="Тестеры:";
            gameDescription[10]="Дарья и Вика";
        
            gameDescription[11]="Вебсайт:";
            gameDescription[12]="www.MadMouseGame.com";
        
            gameDescription[13]="Графика:";
            gameDescription[14]="www.cartoonsolutions.com & www.depositphotos.com";
        
            gameDescription[15]="Звук:";
            gameDescription[16]="www.pond5.com";

            DescHeight={50,70,110,105,90,90,28,             50,30,50,              30,50,30,70,30,70,30,70,30,100};
            Colors=    {1,0, 0, 0, 0, 0,1,              0, 1, 0,                          1,0,1,0,1,0,1,0,1,0};
            FontSize={30,20,20,20,20,20,20,20,20,20,                  20,20,20,20,20,20,20,20,20,20};
        end
        

        if(thegame.GameLanguage=="eng") then
            gameDescription[1]="Help"
            gameDescription[2]="Game Objective:";
            gameDescription[3]="Force the mouse to go into the trap.";
        
            gameDescription[4]="How?";
        
            gameDescription[5]="By throwing to it everything that comes to hand.";
            gameDescription[6]="But how?";
            gameDescription[7]="By drawing a line on the screen to show the angle and force.";
            gameDescription[8]="Longer the line and faster you draw more force will be applied to the object.";
    
            gameDescription[9]="Author:";
            gameDescription[10]="Ivan Komlev";
        
            gameDescription[11]="Motivation:";
            gameDescription[12]="Darya & Vika";
        
            gameDescription[13]="Website:";
            gameDescription[14]="www.MadMouseGame.com";
        
            gameDescription[15]="Graphics:";
            gameDescription[16]="www.cartoonsolutions.com & www.depositphotos.com";
        
            gameDescription[17]="Sounds:";
            gameDescription[18]="www.pond5.com";
            
            DescHeight={50,30,50,30,50,30,28,             70,30,50,              30,50,30,50,30,50,30,50,30,100};
            Colors=    {1, 1, 0, 1, 0, 1, 0,              0, 1, 0,                          1,0,1,0,1,0,1,0,1,0};
            FontSize={30,20,20,20,20,20,20,20,20,20,                  20,20,20,30,20,20,20,20,20,20};
        end
        
        
        
        
        help_scroll = widget.newScrollView
{
    top = 0,
    left = 60,
    width = 400,
    height = 320,
    scrollWidth = 465,
    scrollHeight = 670,
    hideBackground =true
    
}

        local y=30;
        
        for i = 1,#gameDescription, 1 do

            local myText = display.newText( gameDescription[i] , 0, 0,400,DescHeight[i], fontName, FontSize[i]);
            
			myText.anchorY = 0
            myText.X=x;
            myText.y=y;
            if(Colors[i]==1) then
                myText:setTextColor(255,200,0);
            else
                myText:setTextColor(255,255,255);
            end
            

            
            help_scroll:insert (myText);
                
            y=y+DescHeight[i];
        end
        
        AllTransition[#AllTransition+1]=transition.to( coverDeskHelp, { time=500, alpha=0.85 } )
                    
                    
                    

end
    
    
local function DrawHelpWindow_Old(self)

		coverDeskHelp = display.newRect(0, 0,display.contentWidth*2,display.contentHeight*2)
		coverDeskHelp:setFillColor(0,0,0, 250)
        coverDeskHelp.x=display.contentWidth*0.5
        coverDeskHelp.y=display.contentHeight*0.5
        coverDeskHelp.alpha=0
        
	help_window = display.newGroup();

        help_window.width= 400
        help_window.height= 300

	help_window.x =display.contentWidth*0.5---help_window.width*0.5
	help_window.y =0
        help_window.alpha=1
        
        createButtons()
        
        local onSimulator = system.getInfo( "environment" ) == "simulator"
        local platformVersion = system.getInfo( "platformVersion" )
        local olderVersion = tonumber(string.sub( platformVersion, 1, 1 )) < 4
        local fontName = "Grinched"
        local fontSize = 30
        local space=6
        
        local myText1 = display.newText( "Help", 0, 0, fontName, fontSize )
        myText1.x=0--help_window.width*0.5
        myText1.y=30
        myText1:setTextColor(255,200,0)
        myText1.alpha=1
        
        help_window:insert (myText1) 
        
        local myText2 = display.newText( "Game Objective:", 0, 0, fontName, 22)
        myText2.x=0
        myText2.y=myText1.y+myText1.height+space*2
        myText2:setTextColor(0,200,255)
        help_window:insert (myText2)
        
        local myText3 = display.newText( "Force the mouse to go into the trap.", 0, 0, fontName, 20)
        myText3.x=0
        myText3.y=myText2.y+myText2.height+space
        myText3:setTextColor(255,255,255)
        help_window:insert (myText3)
        
        local myText4 = display.newText( "How?", 0, 0, fontName, 22)
        myText4.x=0
        myText4.y=myText3.y+myText3.height+space*2
        myText4:setTextColor(0,200,255)
        help_window:insert (myText4)
        
        local myText5 = display.newText( "By throwing to it everything that comes to hand.", 0, 0, fontName, 20)
        myText5.x=0
        myText5.y=myText4.y+myText4.height+space
        myText5:setTextColor(255,255,255)
        help_window:insert (myText5)

        local myText6 = display.newText( "But how?", 0, 0, fontName, 22)
        myText6.x=0
        myText6.y=myText5.y+myText5.height+space*2
        myText6:setTextColor(0,200,255)
        help_window:insert (myText6)
        
        local myText7 = display.newText( "By drawing a line on the screen to show the angle and force.", 0, 0, fontName, 20)
        myText7.x=0
        myText7.y=myText6.y+myText6.height+space
        myText7:setTextColor(255,255,255)
        help_window:insert (myText7)
        
        local myText8 = display.newText( "Longer the line and faster you draw more force", 0, 0, fontName, 20)
        myText8.x=0
        myText8.y=myText7.y+myText7.height+space
        myText8:setTextColor(255,255,255)
        help_window:insert (myText8)
        
        local myText9 = display.newText( "will be applied to the object.", 0, 0, fontName, 20)
        myText9.x=0
        myText9.y=myText8.y+myText8.height+space
        myText9:setTextColor(255,255,255)
        help_window:insert (myText9)

        AllTransition[#AllTransition+1]=transition.to( coverDeskHelp, { time=500, alpha=0.85 } )
end

function DoBack(self)
    CancelAllTransition()
    
    display.remove(coverDeskHelp)
    coverDeskHelp=nil

    display.remove(help_window)
    help_window=nil
    
    display.remove(help_scroll)
    help_scroll=nil

    mainmenu:ShowCoverButtons()
end

local function BackEvent()
    Runtime:removeEventListener( "key", onKeyEvent )
    display.remove( ButtonBack)
    ButtonBack=nil
    
    AllTransition[#AllTransition+1]=transition.to( coverDeskSettings, { time=200, alpha=0 } )
    Timers[#Timers]=timer.performWithDelay(200,DoBack,1)
end

function Back(event)
   if event.phase == "ended" then
        
        BackEvent()
   end
        
end


function onKeyEvent( event )

    if (event.phase == "up" and event.keyName=="back" ) then
        Runtime:removeEventListener( "key", onKeyEvent )
        BackEvent()
        return true;
    end
    return false;
end


function OpenHelpForm(self)

    buttons:removeAllButtons()

    DrawHelpWindow()
    
    
    --add the runtime event listener
    if system.getInfo( "platformName" ) == "Android" then  
        Runtime:addEventListener( "key", onKeyEvent )
    end
    
end
