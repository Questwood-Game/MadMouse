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

WorldSprites={}
WorldWalls={}
BGSprites={}

TrapBodyIndex=nil

TrapIsOpen=true
ScreenMinX=0
ScreenMaxX=0

ScreenXd=0

NumberOfItems=0
NumberOfItemsUsed=0

local Timers={}

function EraseAllTimers()
    for i=1, #Timers do
            timer.cancel( Timers[i] ) 
            Timers[i]=nil
    end
    Timers={}
end



local WatchVisible=false
local WatchScreenX=nil
if(WatchVisible)then
    local WatchCenter=nil
    local CurrentWatchCenter=nil
end

function StopWinLose()
    EraseAllTimers()
end

function removeTrap(self)

    if(TrapM==nil) then
        return false
    end
       
        display.remove(TrapM)
        TrapM=nil
       
       
        display.remove(TrapImage);
        TrapImage=nil
        
        --if(TrapSensor~=nil and TrapSensor.x~=nil) then
        display.remove(TrapSensor);
        TrapSensor=nil
        --end
			
        display.remove(TrapSide1);
        TrapSide1=nil

        --if(TrapLeg~=nil and TrapLeg.x~=nil) then
        display.remove(TrapLeg)
        TrapLeg=nil


        display.remove(TrapStick)
        TrapStick=nil
        
        TrapBodyIndex=nil
end

function clearWorld(self)

if(WatchVisible)then
     display.remove(WatchCenter)
     display.remove(CurrentWatchCenter)
        WatchCenter=nil
        CurrentWatchCenter=nil
end

        thegame:StopAllPlaying()

        removeTrap();
        
        thegame:RemoveSoundListeners()

	for i,line in ipairs(WorldSprites) do
                                display.remove(WorldSprites[i])
                                WorldSprites[i]=nil;
        end

	WorldSprites=nil--{}
	TrapIsOpen=false
	--TrapBodyIndex=nil
		

	display.remove(TrapImage)
	TrapImage=nil
			
	display.remove(TrapSensor)
	TrapSensor=nil
	
	display.remove(UserSensor)
	UserSensor=nil
        
        display.remove(TrapStick)
	TrapStick=nil
        
        display.remove(TrapSide1)
	TrapSide1=nil
			
	display.remove(TrapSide2)
	TrapSide2=nil
		
	display.remove(TrapLeg)
	TrapLeg=nil
	
		
end




function clearLevel(self)
    if(WorldWalls) then
        for i,line in ipairs(WorldWalls) do
            display.remove(WorldWalls[i])
            WorldWalls[i]=nil
        end
        for i,line in ipairs(BGSprites) do
            display.remove(background.bg[i])
            background.bg[i]=nil
        end
    end
                        
    WorldWalls=nil;
    BGSprites=nil;
end

function SetBackground(self, layer)

    local bgCount=1
    for i,line in ipairs(BGSprites) do

        if BGSprites[i].layer==layer then
			bgCount=i
			background.bg[bgCount] = display.newImageRect( BGSprites[i].image,BGSprites[i].width, BGSprites[i].height)
			background.bg[bgCount].anchorY = BGSprites[i].height
			
			background.bg[bgCount].x = BGSprites[i].x;
            background.bg[bgCount].y = BGSprites[i].y
			background.bg[bgCount].width=BGSprites[i].width;
            background.bg[bgCount].height=BGSprites[i].height
			background.bg[bgCount].dx = BGSprites[i].dx
			background.bg[bgCount].originalX=BGSprites[i].x
			background.bg[bgCount].layer=BGSprites[i].layer

            bgCount=bgCount+1
        end
    end
end


function SetWalls(self)
		
	--Set World Walls
    local CollisionFilter = { categoryBits = 1, maskBits = 3 } 
    local CollisionFilterClose = { categoryBits = 4, maskBits = 3 } 

	for i,line in ipairs(WorldWalls) do
	
		game:insert(WorldWalls[i])
				
        if(WorldWalls[i].myName==nil)then 
            WorldWalls[i].myName="Wall"
            physics.addBody(WorldWalls[i], "static", { friction=WorldWalls[i].physics.friction, bounce=WorldWalls[i].physics.bounce, filter=CollisionFilter }  )
        else
            physics.addBody(WorldWalls[i], "static", { friction=WorldWalls[i].physics.friction, bounce=WorldWalls[i].physics.bounce, filter=CollisionFilterClose }  )
        end
    end

    if(WatchVisible)then
        WatchCenter = display.newRect(0 ,0,10,10)
        WatchCenter:setFillColor(0,0,255,200)
        
        WatchCenter.x =0
        WatchCenter.y = 100
        WatchCenter.rotation=0

        CurrentWatchCenter = display.newRect(0 ,0,10,10)
        CurrentWatchCenter:setFillColor(0,255,0,200)
        CurrentWatchCenter.x =0
        CurrentWatchCenter.y = 80
        CurrentWatchCenter.rotation=0
    end
    
		
end


function DoWin(self)
    if(thegame.PlaySound) then
        local availableChannel = audio.findFreeChannel()
        local index=math.random( #thegame.winSounds )
    
        audio.setVolume( 0.5, { channel=availableChannel } )
        audio.play( thegame.winSounds[index], { channel=availableChannel } )
    end
        
    winform:Won()
end

function DoLose(self)
    if(thegame.PlaySound) then
        local availableChannel = audio.findFreeChannel()
        local index=math.random( #thegame.loseSounds )
    
        audio.setVolume( 0.5, { channel=availableChannel } )
        audio.play( thegame.loseSounds[index], { channel=availableChannel } )
    end
        
    loseform:Lost(false)
end

local function MouseEatYou()
        
	-- You Lost !!!
        thegame:removeSkyDropListener()
        mousecharacter:StopMouse();
                        
        mousecharacter:RemoveMiceVisor();
        
        Timers[#Timers]=timer.performWithDelay(200,DoLose,1)
end

local function closeTrap()
	
	-- You Won !!!

	TrapIsOpen=false
    thegame:removeSkyDropListener()

    buttons:removeAllButtons();
    thegame:cancelAlltimers();
        
    mousecharacter:StopMouse()
    
	local opacity=0
	local weightSide=WorldSprites[TrapBodyIndex].width/8

	-- drop stick
	TrapStick.x=TrapStick.x-10*TrapDirection
	TrapStick.rotation=-20*TrapDirection
	TrapStick.myName="TrapStick"
	physics.addBody (TrapStick, {bounce = 0.4, density=20, friction = 100})
	TrapStick:applyForce( -1040*TrapDirection,0, TrapStick.x, TrapStick.y)
                        
    TrapM:applyForce( 0,1040, TrapM.x, TrapM.y)

    display.remove(TrapLeg)
    TrapLeg=nil

    mousecharacter:RemoveMiceVisor();
        
    if(thegame.PlaySound) then        
		local availableChannel = audio.findFreeChannel()
        local index=math.random( #thegame.trapSounds )
        audio.setVolume( 1, { channel=availableChannel } )
        audio.play( thegame.trapSounds[index], { channel=availableChannel } )
    end
       
    Timers[#Timers]=timer.performWithDelay(1000,DoWin,1)
end

local function onTrapCollision( self, event )
        if ( event.phase == "began" ) then
                
		if TrapIsOpen==true and self.myName=="InsideTrap" and event.other.myName=="character" then
                    TrapIsOpen=false
                    local LocalTimer=nil
                   local toDo= function()
                       timer.cancel(LocalTimer)
                       LocalTimer=nil
                       --if TrapSensor~=nil then
                       display.remove(TrapSensor)
                       TrapSensor=nil
                       
                       --end
                    thegame:cancelAlltimers()
                    buttons:removeAllButtons();
                    closeTrap()
                    
                   end
                   LocalTimer=timer.performWithDelay(10,toDo,1)
 		end
        end
end

local function onUserSensorCollision( self, event )

        if ( event.phase == "began" ) then
                if self.myName=="UserSensor" and event.other.myName=="character" then
            
                    --Mouse is Over You
                    local toDo = function()
                    
                        if TrapIsOpen==true and TrapSensor then
                            display.remove(TrapSensor)
                            TrapSensor=nil
                        end
                        if(UserSensor~=nil) then
                            UserSensor:removeEventListener( "collision", UserSensor )
                        end
                        
                        display.remove(UserSensor)
                        UserSensor=nil
                
                        thegame:cancelAlltimers()
                        buttons:removeAllButtons();
                        MouseEatYou()
                    end
                    Timers[#Timers]=timer.performWithDelay(100,toDo,1)
                   
                end
        end
end
 

function setUserSensor(self, x, y)

    UserSensor=display.newRect(0, 0, 50, 70)
    UserSensor:setFillColor(0, 255,255, 0)

    UserSensor.x=x
    UserSensor.y=y-25
    
    game:insert(UserSensor)

    UserSensor.myName="UserSensor"
    physics.addBody (UserSensor, "static",{ isSensor = true})
    UserSensor.collision = onUserSensorCollision
    UserSensor:addEventListener( "collision", UserSensor )
end

function dropTrap(self, s,typeIndex,x,y,rotation,direction,trapImage)
        print("Drop Trap")
        TrapDirection=direction
        local CollisionFilter = { categoryBits = 1, maskBits = 1 } 

			if TrapBodyIndex~=nil then
				--cannot have more than one trap
                    print("cannot have more than one trap")
				return false
				
			end
			TrapBodyIndex=#WorldSprites+1
			
			local opacity=0
			local weightSide=s.width/4

			TrapIsOpen=true
	
			local boxWidth=s.width--+s.width
	
			WorldSprites[#WorldSprites+1]=display.newRect(0 ,0,boxWidth,5)
			WorldSprites[#WorldSprites]:setFillColor(50, 100,255, opacity)
			game:insert(WorldSprites[#WorldSprites])
			WorldSprites[#WorldSprites].x=x
			WorldSprites[#WorldSprites].y=y
			WorldSprites[#WorldSprites].myName="TrapPart1"
			WorldSprites[#WorldSprites].bodyIndex=#world.WorldSprites
			WorldSprites[#WorldSprites].typeIndex=typeIndex

			physics.addBody (WorldSprites[#WorldSprites], {bounce = s.bounce, density=5, friction = 1, filter=CollisionFilter})

			--Counterweight
                       
            TrapM=display.newRect(0,0,5,5)
			TrapM:setFillColor(255, 0,0,opacity)
			game:insert(TrapM)
			TrapM.x=x-(s.width*0.5-5)*direction
			TrapM.y=y-10

			TrapM.myName="TrapM"
			physics.addBody (TrapM, {bounce = s.bounce, density=s.density*5, friction = s.friction, filter=CollisionFilter})
			local TrapMJoint = physics.newJoint ( "weld", WorldSprites[#WorldSprites], TrapM, TrapM.x,y-10)
			
                        if trapImage==nil then
                            TrapImage =display.newImageRect( "src/images/traps/"..s.image ,s.width,s.height)
                        else
                            TrapImage =display.newImageRect( "src/images/traps/"..trapImage ,s.width,s.height)
                        end

			
			TrapImage.anchorY = 0
			game:insert(TrapImage)
			TrapImage.x=WorldSprites[#WorldSprites].x
			TrapImage.y=WorldSprites[#WorldSprites].y


			---
			TrapSensor=display.newRect(0, 0, s.width*0.5, s.height-10)
			
			TrapSensor.anchorY = 0
			TrapSensor:setFillColor(0, 255,255, opacity)
			game:insert(TrapSensor)
			TrapSensor.x=WorldSprites[#WorldSprites].x
			TrapSensor.y=WorldSprites[#WorldSprites].y
			TrapSensor.myName="InsideTrap"
			physics.addBody (TrapSensor,{ isSensor = true, filter=CollisionFilter })
			TrapSensor.collision = onTrapCollision
			TrapSensor:addEventListener( "collision", TrapSensor )
			---
			
			TrapSide1=display.newRect(0 ,0,5,s.height)
			
			TrapSide1:setFillColor(50, 100,255, opacity)
			game:insert(TrapSide1)
			TrapSide1.x=x+(s.width*0.5)*direction
			TrapSide1.y=y+s.height*0.5
			
			TrapSide1.myName="TrapSide"
			physics.addBody (TrapSide1, {bounce = s.bounce, density=s.density, friction = s.friction, filter=CollisionFilter})
			local TrapJoint1 = physics.newJoint ( "weld", WorldSprites[#WorldSprites], TrapSide1, x, y+s.height*0.5)
			TrapJoint1.isLimitEnabled = true	

			--Counterweight
			TrapLeg=display.newRect(0 ,0,20,1)
			TrapLeg.anchorY = 1
			
			TrapLeg:setFillColor(255, 0,0, opacity)
			game:insert(TrapLeg)
			TrapLeg.x=x-(boxWidth*0.5-5)*direction
			TrapLeg.y=y+s.height*2
			TrapLeg.rotation=-28*direction
			TrapLeg.myName="TrapLeg"
			physics.addBody (TrapLeg, {bounce = s.bounce, density=300, friction = s.friction, filter=CollisionFilter})
			local TrapLegJoint = physics.newJoint ( "weld", WorldSprites[#WorldSprites], TrapLeg, TrapLeg.x,y)
			
			
			TrapStick =display.newImageRect("src/images/traps/trap_stick.png" ,12,50)
			TrapStick.anchorY = 50
			game:insert(TrapStick)
			TrapStick.x=TrapLeg.x
			TrapStick.y=TrapLeg.y

			WorldSprites[#WorldSprites].rotation=rotation
end

local function getViewWidth(x)
        local minx=100000
        local maxx=-100000
        local floor=math.floor
        
        for i=1,#x do
            if x[i]<minx then minx=floor(x[i]); end
            if(x[i]>=maxx) then maxx=floor(x[i]); end
        end

        return {floor(maxx-minx),floor(minx+(maxx-minx)*0.5)}
end

function moveCamera(self)
    
    if(buttons.physics_paused)then
        return false;
    end

    local wx={}
    
    local WindowWidth=display.contentWidth-250
    local halfScreen=WindowWidth*0.5

    local d=""
    local abs=math.abs
    local floor=math.floor
    local timx=0
    --if(world.TrapSensor~=nil and world.TrapSensor.x~=nil) then
            timx=TrapImage.x
    --end
    local mcwx=0
    --if(mousecharacter.wheel~=nil and mousecharacter.wheel.x~=nil) then
            mcwx=mousecharacter.wheel.x
    --end
    --print ("thegame.CameraWatch="..thegame.CameraWatch)
    --print ("mcwx="..mcwx)
    --print ("timx="..timx)
    
    if(thegame.WatchForSprite==nil or thegame.WatchForSprite==-1) then
        --watch for mouse and user and trap if possible
        
        
        
        wx=getViewWidth({thegame.UserPositionX,mcwx,timx});
        w=wx[1]
        
        if(abs(w)<WindowWidth) then
            -- show both user and mouse, they both fit into screen
            --All Visible
            WatchScreenX_New=wx[2]
        else
            -- priority to selected view
            local WatchScreenX_New2=0
            w=10
            if thegame.CameraWatch==1 then
                --girl
                WatchScreenX_New2=floor(thegame.UserPositionX)
            elseif thegame.CameraWatch==2 then
                --mouse
                WatchScreenX_New2=floor(mcwx)
            else
                --trap
                WatchScreenX_New2=floor(timx)
            end
            
            
            if(WatchScreenX_New2<wx[2]) then
                WatchScreenX_New=WatchScreenX_New2+halfScreen
            else
                WatchScreenX_New=WatchScreenX_New2-halfScreen    
            end
            
       end
   
    else
        --watch for mouse and user and trap and flying object if possible
        if(thegame.WatchForSprite>#world.WorldSprites) then
            return;
        end
        
        wx=getViewWidth({thegame.UserPositionX,mcwx,timx,world.WorldSprites[thegame.WatchForSprite].x});
        w=wx[1]
        
        if(abs(w)<WindowWidth) and 1==7 then
            -- show user and mouse and sprite, they are fit into screen
            WatchScreenX_New=wx[2]
        else
            -- priority to sprite
            w=10
            WatchScreenX_New2=floor(world.WorldSprites[thegame.WatchForSprite].x)
            
            if(WatchScreenX_New2<wx[2]) then
                WatchScreenX_New=WatchScreenX_New2+halfScreen
            else
                WatchScreenX_New=WatchScreenX_New2-halfScreen    
            end
        end
    end
        
       
            
    if(WatchScreenX==nil) then
            WatchScreenX=WatchScreenX_New
    end
        
    if (WatchScreenX_New-abs(w)<WatchScreenX-halfScreen) or (WatchScreenX_New+abs(w)>WatchScreenX+halfScreen) then
            --Away of sight
            WatchScreenX=WatchScreenX_New
    end
  
    if(WatchVisible)then
            WatchCenter.x=WatchScreenX_New
            CurrentWatchCenter.x=WatchScreenX
    end

    local halfScreenFull=display.contentWidth*0.5
    local newGameX=- WatchScreenX+halfScreenFull
        
    local DistanceX=floor(game.x)-newGameX
    --print("DistanceX="..DistanceX)
    if(buttons.GameMode==1) then
        local newGameX=floor(game.x)-DistanceX/thegame.CameraSpeed
        game.x = newGameX

    end
        
    
    background:MoveBackGround(game.x)
    mousecharacter:MoveCharacter()
end

-- tAjALAWA6A@A2A6A4A8A9A3A