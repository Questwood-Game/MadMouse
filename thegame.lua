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
-- eng, rus
GameLanguage="rus"
local Loading=nil
local LoadingShadow=nil


CurrentLevel=0
MaxLevel=1

TotalScores=0
CurrentLevelScores=0

DropFromX=0
DropFromY=0

UserPositionX=0
UserPositionY=0

TimeFromTouch=0

WatchForSprite=-1   


winSounds={}
loseSounds={}
tryagainSounds={}

trapSounds={}
bodyFlySounds={}
bodyHitSounds={}
mousePainSounds={}
mouseEatSounds={}
mouseJumpSounds={}
userDropSounds={}

PlaySound=true
PlayMusic=true

CameraSpeed=10

UserArmLength =10

CurrentSprite=-1
NextSprite=-1
CheeseIndex=-1
CameraWatch=1

--local timerId={}
local LoseGameTimer=nil
local SpriteWatchTimer=nil

local MouseSound=false

local SpriteArrow


local Timers={}
function EraseAllTimers()
    for i=1, #Timers do
            timer.cancel( Timers[i] ) 
            Timers[i]=nil
    end
    Timers={}
end

BackGroundMusicChannel=-1

function StopAllPlaying()
    BackGroundMusicChannel=-1
    local result = audio.usedChannels

    if(result>0) then
        for i=1,result do
            audio.stop( i)

        end
   end
end

local function getsign(x)
    if(x>=0) then
        return 1;
    else
        return -1;
    end
end

function EatCheese(self, index,attraction)
                            
              if(index~=nil )then
                  if world.WorldSprites[index]~=nil then
                        
                        
                        if(thegame.PlaySound) then      
                            local availableChannel = audio.findFreeChannel()
                            local index=math.random( #mouseEatSounds )
                            audio.setVolume( 0.4, { channel=availableChannel } )
                            audio.play( mouseEatSounds[index], { channel=availableChannel } )
                        end
                        
                        world.WorldSprites[index]:removeEventListener("postCollision", onBodyCollision)
                        
                        
                        local doCollision = function()
                            world.WorldSprites[index].isBodyActive = false
                            --world.WorldSprites[index].isVisible=false
                            world.WorldSprites[index].y=10000
                        end
                        
                        local collisionTimer = timer.performWithDelay( 10, doCollision, 1 )
                        
                        --world.WorldSprites[index]:setLinearVelocity(0, 0)
                        --world.WorldSprites[index].angularVelocity = 0
                        --world.WorldSprites[index].isBodyActive = false


                        --table.remove (world.WorldSprites,index)
                        
                        
                       -- movements.MouseJumpForce=movements.MouseJumpForce+attraction*10
                        
                        mousecharacter:StopMouse();
                        
                        
                        mousecharacter:changeFace(0,100,{2,3,4,10,11,8,11,10,8,1,4,3})
                        --wheel:applyForce(0,movements.MouseJumpForce, wheel.x, wheel.y)--
                        
                        
                        
                        
                        
                   end
              end          
                        
end

local function getAttractionSprite(UserArmLength_)
                
                local SpriteIndex=-1

		local MinDistance=1000000;

		local abs=math.abs
                --local sqrt=math.sqrt
                
		for i,line in ipairs(world.WorldSprites) do
			local s=world.WorldSprites[i]
			if s.myName=="body" then
                                
                                local attraction=sprite_collection.SpriteColection[s.typeIndex].attraction
                                if attraction~=nil then

                      
                                    local dX=abs(mousecharacter.wheel.x-s.x)
                                    local dY=abs(mousecharacter.wheel.y-s.y)

                                    if dX<UserArmLength_ and dY<100 then
                                        if dX<MinDistance then 
                                            MinDistance=dX
                                            SpriteIndex=i
                                        end
                                    end
                               end
                                
			end
		end
		return SpriteIndex;

end

local function getSprite()
                
                local SpriteIndex=-1
                
                --if(CurrentSprite~=nil and CurrentSprite~=-1) then
                    -- disable bullet
                  --  world.WorldSprites[CurrentSprite].isBullet = false
                --end
                
                
		--local yM=display.contentHeight-y
		local MinDistance=1000000;
                --CurrentSprite=-1;
		local abs=math.abs
                local sqrt=math.sqrt
                local SpriteIndexAlternative=-1
                
		for i,line in ipairs(world.WorldSprites) do
			local s=world.WorldSprites[i]
                        
                        if i~=WatchForSprite then
                        
                            if s~=nil and s.myName=="body" and s.isBodyActive then
                            
                                                    
                                local dX=abs(UserPositionX-s.x)
                                local dY=abs(UserPositionY-s.y)
                                local d=sqrt(dX*dX+dY*dY)

                                if d<UserArmLength then
                                    SpriteIndexAlternative=i
                                    if(i~= CurrentSprite) then

                                        if d<MinDistance then 
                                            MinDistance=d
                                            SpriteIndex=i
                                        end
                                        
                                    end
                                end --if d<UserArmLength then
                                
                            end --if s~=nil and s.myName=="body" and s.isBodyActive then
                       end --if i~=WatchForSprite then
		end --for
                
                if (SpriteIndex==-1) then
                    SpriteIndex=SpriteIndexAlternative
                end
                
		return SpriteIndex;

end




function findCheese()
    CheeseIndex=getAttractionSprite(400);
    if CheeseIndex~=-1 then
        mousecharacter:RunForCheese(CheeseIndex)
    end
end


function PrepareSpriteArraw()
    
    SpriteArrow = display.newImageRect( "src/images/misc/spritearrow.png",20,26)
    SpriteArrow:setReferencePoint(display.BottomCenterReferencePoint);
    SpriteArrow.isVisible = false;
    game:insert (SpriteArrow)
end

function animateArrow(self)
    
    if(NextSprite~=nil and NextSprite~=-1 and buttons.physics_paused==false) then
        local y=world.WorldSprites[NextSprite].y

            SpriteArrow.y=y-30
            transition.to( SpriteArrow, {delay=0, time=200, y=y-20} )  

    end
end
function setArrowX(self)
    
    findCheese()
    
   if(NextSprite~=nil and NextSprite~=-1) then
        local abs=math.abs
        local dX=abs(UserPositionX-world.WorldSprites[NextSprite].x)
        local dY=abs(UserPositionY-world.WorldSprites[NextSprite].y)
        local d=math.sqrt(dX*dX+dY*dY)
        
        if d<UserArmLength then
       
            SpriteArrow.x=world.WorldSprites[NextSprite].x
       
            if SpriteArrow.y>world.WorldSprites[NextSprite].y-20 or SpriteArrow.y<world.WorldSprites[NextSprite].y-40 then
                animateArrow()
            end
        else
            SpriteArrow.isVisible=false
            

            NextSprite=nil

            FindNextSprite()
            if NextSprite==-1 then
                
            else
                SpriteArrow.isVisible=true
            end
        end
   end
end

function FindNextSprite(self)
    
    NextSprite=getSprite()
    
    if(NextSprite~=nil) then
        if(NextSprite~=-1) then
            --Next Sprite Found;
        
            SpriteArrow.x=world.WorldSprites[NextSprite].x
            SpriteArrow.isVisible = true;
        
            Timers[#Timers]=timer.performWithDelay(300,animateArrow,10)

        
            if(thegame.CameraSpeed~=80 and WatchForSprite~=nil and WatchForSprite~=-1) then
                WatchForSprite=NextSprite
                Timers[#Timers]=timer.performWithDelay(1000,DisableSpriteWatch,1)
            end
        else
            SpriteArrow.isVisible = false;
            --startcounter
            
            
            
            --local myclosure= function() 
                
            --end
            
            --LoseGameTimer=timer.performWithDelay(5000,myclosure,1)
            
        end
    else
        NextSprite=-1
        SpriteArrow.isVisible = false;
    end
    
    
    
    
    --Face_Eyes.x=Face.x+xOffsets.faceeyes
    --Face_Eyes.y=y+yOffsets.faceeyes
    
    --Face_Eyes.isVisible = true;
end



local function CreateBodyClone(CurrenBodyIndex,JustDropped)
    
    
    local OldBody=world.WorldSprites[CurrenBodyIndex]
    local angularVelocity=OldBody.angularVelocity
    local lvX,lvY=OldBody:getLinearVelocity()
        
    if(buttons.physics_paused or buttons.GameMode==0)then
        return false
    end
    
    if angularVelocity==nil or lvX==nil or lvY==nil then 
        return false
    end
    OldBody.isBodyActive=false
    
    local s=sprite_collection.SpriteColection[OldBody.typeIndex]
    
    local NewBody=display.newImageRect( "src/images/sprites/"..s.image,s.width,s.height  )
    NewBody:setReferencePoint( display.CenterCenterReferencePoint)
    local CollisionFilter = { categoryBits = 1, maskBits = 5 }   
    
    
    if JustDropped then
        --NewBody:setFillColor(0,0,255,50)
        CollisionFilter = { categoryBits = 1, maskBits = 3 } 
    end
    
    game:insert(NewBody)
    NewBody.x=OldBody.x
    NewBody.y=OldBody.y
    NewBody.rotation=OldBody.rotation
    NewBody.bodyIndex=OldBody.bodyIndex
    NewBody.typeIndex=OldBody.typeIndex
    NewBody.myName=OldBody.myName
    NewBody.used=OldBody.used

    

    if(s.radius>0) then
        physics.addBody (NewBody, {bounce = s.bounce, density=s.density, friction = s.friction, radius=s.radius, filter=CollisionFilter})
    else
        if s.shape==nil then
            physics.addBody (NewBody, {bounce = s.bounce, density=s.density, friction = s.friction, filter=CollisionFilter})        
        else
            physics.addBody (NewBody, {shape=s.shape, bounce = s.bounce, density=s.density, friction = s.friction,filter=CollisionFilter})
        end
    end 
    
    NewBody.angularVelocity=angularVelocity
    
    
    NewBody:setLinearVelocity(lvX,lvY)
    
    
    
    return NewBody;
end


function DisableSpriteWatch(self)
    
    if(buttons.physics_paused or buttons.GameMode==0)then
        return false
    end
        
    if SpriteWatchTimer~=nil then
        timer.cancel(SpriteWatchTimer)
        SpriteWatchTimer=nil
    end
    --EraseAllTimers()
    
   if(WatchForSprite~=nil and WatchForSprite~=-1) then
        local NewBody=CreateBodyClone(WatchForSprite,false)
        if NewBody~=false then
        
            world.WorldSprites[WatchForSprite]:removeEventListener("postCollision", onBodyCollision)
            
            display.remove(world.WorldSprites[WatchForSprite])
            world.WorldSprites[WatchForSprite]=nil
            
            world.WorldSprites[WatchForSprite]=NewBody
            world.WorldSprites[WatchForSprite]:addEventListener("postCollision", onBodyCollision)
        else
            return false;
        end
   end
    
    
    
   WatchForSprite=-1
   CameraSpeed=20
   if(CurrentSprite~=nil and CurrentSprite~=-1) then
    -- disable bullet
        world.WorldSprites[CurrentSprite].isBullet = false
   end
   
   
   mousecharacter:changeFace(500,2000,{4,3,4,1})

    if(NextSprite~=nil and NextSprite~=-1) then
        SpriteArrow.isVisible=true
    end
    
    if(CameraWatch~=1) then
        CameraWatch=1
        buttons:CreateCameraButton()
    end
end


function DisableMouseSound()
    MouseSound =false
end

function onBodyCollision(event)
    

        if (event.force==nil) then
            return 
        end
        
       
        if (event.force<1) then
            return 
        end
  
        if event.other.myName=="character" and event.target~=nil then
            if world.WorldSprites[event.target.bodyIndex].myName=="body" then
                
    
                local attraction=sprite_collection.SpriteColection[event.target.typeIndex].attraction
                if attraction~=nil then

                end
                

                if PlaySound and MouseSound~=true and #mousePainSounds>0 then

                    local v=event.force
        
                    if v<1 then
                        v=1
                    end
                    if(v>10) then
                        v=10
                    end

                    local volume=1/10*v

                    if(volume>0.2) then
                        mousecharacter:changeFace(0,1000,{4,1})
                        mousecharacter:changeEyes(0,500,{3,2,1})
                    end
                    if(volume>0.7 and WatchForSprite~=nil and WatchForSprite~=-1) then
                        
                        --mouse  cry only when you hit it hard
                        local availableChannel = audio.findFreeChannel()
                        local index=math.random( #mousePainSounds )
                        audio.setVolume( volume, { channel=availableChannel } )
                        audio.play( mousePainSounds[index], { channel=availableChannel } )
                        MouseSound =true
                        Timers[#Timers]=timer.performWithDelay(1000,DisableMouseSound,1)
                    end
                end
            end
        end
        
        if world.WorldSprites[event.target.bodyIndex].myName=="body" then

            if event.other.myName=="Wall" or event.other.myName=="body" then
            

            local typeIndex=event.target.typeIndex
            local s=sprite_collection.SpriteColection[typeIndex]
            local vx,vy = event.target:getLinearVelocity()

            local v=event.force
        
            if v<1 then
                v=1
            end
            if(v>10) then
                v=10
            end
        
            local volume=s.volume/10*v/100

                    
            if(volume>0.1) then
                
                if (PlaySound and s.hitsound~=-1) then
                    local availableChannel2 = audio.findFreeChannel()
                    audio.setVolume(volume, { channel=availableChannel2 } )
                    audio.play( bodyHitSounds[s.hitsound], { channel=availableChannel2 } )
                end
                
                if(volume>0.4) then

                end
            end
            
            end
        end

end



local function DropBody(x,y)
    if buttons.physics_paused then
        return
    end
    
    
    TimeFromTouch=0

    if NextSprite ==-1 or NextSprite==nil then

         FindNextSprite()
    end
    
    if NextSprite ==-1 or NextSprite==nil then
        
        
            if(thegame.PlaySound) then
                local availableChannel = audio.findFreeChannel()
                local index=math.random( #tryagainSounds )
    
                audio.setVolume( 0.5, { channel=availableChannel } )
                audio.play( tryagainSounds[index], { channel=availableChannel } )
            end
            
            local toDo=function()
                removeSkyDropListener()
                cancelAlltimers()
                buttons:removeAllButtons();
                loseform:Lost(true)
            end
            
            Timers[#Timers]=timer.performWithDelay(10,toDo,1)
        
        
        return false;
    end
    
    CurrentSprite= NextSprite
    if CurrentSprite==WatchForSprite then
        NextSprite=-1;
        CurrentSprite=-1;
        print ("CurrentSprite==WatchForSprite ");
        return
    end
    
    NextSprite=-1;
    FindNextSprite()
    

    
    local kD=3

    
    local dfx=x-DropFromX
    local dfy=y-DropFromY
    
    if math.abs(dfx)<10 and math.abs(dfy)<10 then
        return false
    end
   
    local kX=dfx*kD--*kT--+kT*getsign(dfx)
    local kY=dfy*kD--*kT--+kT*getsign(dfy)

    
    local r=getsign(dfy)
                
                
    if(WatchForSprite~=nil and WatchForSprite~=-1) then
        DisableSpriteWatch();
        
    end
                
                 
    local NewBody=CreateBodyClone(CurrentSprite,true)
    if not NewBody then
       return false
    end
    world.NumberOfItemsUsed=world.NumberOfItemsUsed+1
    
    display.remove(world.WorldSprites[CurrentSprite])
    world.WorldSprites[CurrentSprite]=nil
            
    world.WorldSprites[CurrentSprite]=NewBody
    world.WorldSprites[CurrentSprite]:addEventListener("postCollision", onBodyCollision)
    
    
    world.WorldSprites[CurrentSprite].x=UserPositionX
    world.WorldSprites[CurrentSprite].y=UserPositionY
    world.WorldSprites[CurrentSprite].alpha=1
    world.WorldSprites[CurrentSprite].isBullet = true
    world.WorldSprites[CurrentSprite]:applyForce(kX,kY, UserPositionX+r, UserPositionY+r)
    
    local CollisionFilter = { categoryBits = 6, maskBits = 1 } 
    world.WorldSprites[CurrentSprite].filter=CollisionFilter

    WatchForSprite=CurrentSprite;
    
    if(CameraWatch~=2) then
        CameraWatch=2
        buttons:CreateCameraButton()
    end

    
    if(thegame.PlaySound) then
        local index=world.WorldSprites[CurrentSprite].typeIndex
        local s=sprite_collection.SpriteColection[index]
        if(s.flysound~=-1) then
            
            


            local myclosure= function()
                local availableChannel1 = audio.findFreeChannel()
                audio.setVolume(1, { channel=availableChannel1 } )    
                audio.play(bodyFlySounds[s.flysound], { channel=availableChannel1 } )
            end
            Timers[#Timers]=timer.performWithDelay(250,myclosure,1)
        end
        
        local availableChannel2 = audio.findFreeChannel()
        local index=math.random( #userDropSounds )
        audio.setVolume( 0.1, { channel=availableChannel2 } )
        audio.play( userDropSounds[index], { channel=availableChannel2 } )
        
    end
    
    if kX>0 then
        --usercharacter:turnHead2Right()
        --usercharacter:turnTorsoAndLegs2Right()
        
        usercharacter:turnBody2Right();
    else
        --usercharacter:turnHead2Left()
        --usercharacter:turnTorsoAndLegs2Left()
        usercharacter:turnBody2Left();
    end
    
    usercharacter:turnTorso2Side(200,true)
    usercharacter:changeFace(300,100,{12,11,4,3,2,1})
    --usercharacter:changeFace(800,200,{3,2,1})
    usercharacter:turnTorso2Side(1000,false)
    
    --usercharacter:changeFace(0,0,{5})
    --usercharacter:closeEyes(100,50);
    --usercharacter:openEyes(1000,50);
    --usercharacter:blinkEyes(1500,50,0);
    --usercharacter:changeFace(500,150,{3,1})
    
    mousecharacter:changeFace(0,500,{5})
    
    if SpriteWatchTimer~=nil then
        timer.cancel(SpriteWatchTimer)
        SpriteWatchTimer=nil
    end
    SpriteWatchTimer=timer.performWithDelay(2000,DisableSpriteWatch,1)
    
    SpriteArrow.isVisible=true
    
    
    
end


function DropBodyDemo(self,delay,x,y,k,xfrom,yfrom)

    if(demo.Finger) then
        local myclosure= function() if(demo.Finger) then DropFromX=xfrom; DropFromY=yfrom;DropBody(x,y,k); end; end
        Timers[#Timers]=timer.performWithDelay(delay,myclosure,1)
        
    end
    
end

function AddSoundListeners()
    for i,line in ipairs(world.WorldSprites) do
        --world.WorldSprites[i]:addEventListener("postCollision", onBodyCollision)
    end
end

function RemoveSoundListeners()
    for i,line in ipairs(world.WorldSprites) do
        --world.WorldSprites[i]:removeEventListener("postCollision", onBodyCollision)
    end
end

function touchSky( event )
       
        
        if(buttons.physics_paused or buttons.GameMode==0)then
            print ("Touch Sky when game paused - should be imposible")
            return false
        end
    
        if(demo.Finger) then
            EraseAllTimers()
            --for i=1, #timerId do
              --  timer.cancel( timerId[i] ) 
                --timerId[i]=nil
            --end
            timerId={}
            demo:removeMe(0)
    
        end
    
        --if TimeFromTouch==nil then
          --  TimeFromTouch=0
        --end

        
        if(event.phase== "began") then
            DropFromX=event.x-game.x
            DropFromY=event.y-game.y
           -- TimeFromTouch=system.getTimer()

        end
         --or TimeFromTouch==0
  	if(event.phase~= "ended") then
            return false
 	end       
        --print ("Touch Sky to drop")
         --2000-system.getTimer()+TimeFromTouch
        local doDropBody=function()
            DropBody(event.x-game.x,event.y-game.y);    
        end
        
        Timers[#Timers]=timer.performWithDelay(10,doDropBody,1)
        
        
end



function setSkyDropListener(self)
	print ("Set Sky Listener");
	background.sky:addEventListener( "touch", touchSky)
	
end

function removeSkyDropListener(self)
	print ("remove Sky Listener");
	background.sky:removeEventListener( "touch", touchSky)
	
end

function cancelAlltimers()
        world:StopWinLose();
        usercharacter:EraseAllTimers()
        mousecharacter:EraseAllTimers()
        
        
        --if SpriteWatchTimer~=nil then
          --  timer.cancel(SpriteWatchTimer)
            --SpriteWatchTimer=nil
        --end
    
        EraseAllTimers()
        --for i=1, #timerId do
          --  timer.cancel( timerId[i] ) 
           -- timerId[i]=nil
        --end
        --timerId={}
        
        if(demo.Finger) then
            --demo:removeMe(0)
            demo:doRemoveMe()
            TimeFromTouch=0
        end
end

local WaitUntilGameIsRemoved_Timer=nil


local function WaitUntilGameIsRemoved()
    --if game~=nil and game.x~=nil then
      --          print ("Wait until the game is removed");
                --timer.performWithDelay(100,WaitUntilGameIsRemoved,1)--no need to clean this timer
        --    else
                print ("Game is removed");
                background.sky.isVisible=false

                --timer.cancel(WaitUntilGameIsRemoved_Timer)
                --WaitUntilGameIsRemoved_Timer=nil
                
                LoadLevel();
                display.remove(Loading)
                Loading=nil
                
                display.remove(LoadingShadow)
                LoadingShadow=nil
    --end
end



function Replay(self,MustLoadLevel)
        if game~=nil then
            
            --game.isVisible=false
            game.isVisible=false;
        end
        cancelAlltimers();
        
        
        local fontName = "Grinched"
        local fontSize = 50
        local txt=nil;
        if(thegame.GameLanguage=="rus") then
            fontName = "Basic Comical NC"
            txt="Загрузка...";
        else
            txt="Loading..."
        end

        
        LoadingShadow = display.newText(txt , 0, 0, fontName, fontSize )
        LoadingShadow:setReferencePoint(display.CenterCenterReferencePoint);
        LoadingShadow.x=display.contentWidth*0.5+3
        LoadingShadow.y=display.contentHeight*0.5+3
        LoadingShadow:setTextColor(0,0,0)
        
        Loading = display.newText(txt , 0, 0, fontName, fontSize )
        Loading:setReferencePoint(display.CenterCenterReferencePoint);
        Loading.x=display.contentWidth*0.5
        Loading.y=display.contentHeight*0.5
        Loading:setTextColor(255,200,0)

    
        display.remove(SpriteArrow)
        SpriteArrow=nil
        
        remove_enterFrameListener()
        cancelAlltimers();
        advertising:HideAd();
            
        mousecharacter:EraseAllTimers()
            
        if game then
                world:clearWorld()
                world:clearLevel()
        end
            
        local toDo=function()
            
            buttons.physics_paused=true
            physics.pause()


            --physics.stop() -- fires error oniOS

            mousecharacter:removeMouse()
            usercharacter:removeCharacter()
        
            display.remove(game)
            game=nil
            print("Replay - load level")
        
        end
        local t1=timer.performWithDelay(300,toDo,1)
        
        local t2=timer.performWithDelay(700,WaitUntilGameIsRemoved,1)--no need to clean this timer
            
        --end
        
end




