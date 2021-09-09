--
-- Project: Mad Mouse
-- Description: 
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 . All Rights Reserved.
-- 
module(..., package.seeall)

--local FaceFront=false
local EyesSide=nil
local EyesFront=nil
local Front=nil
local EyesState=nil
local changeFaceTimers={}
local changeEyesTimers={}
local tail_shake=0
local tail_shake_d=1
local moveto=0
local timeFromDirectionChange=0

ReadyToTurn=false
MouseJumpForce=0
MouseFeerForce=0
MouseJumpsOnCloseWall=false

local turnTimer=nil
local mouseVisorTimer=nil
local mouseJumpTimer=nil
local mouseJumpTimer2=nil

local character_Xoffsets={}
local character_Yoffsets={}
local isMouseOk=true

------
local leg=1
local leg_max=0
local head=nil
local neck=nil
torso=nil
wheel=nil
local leg_back = nil
local arm_back = nil
local tail = nil
------
local character=nil

local characterJoints_Wheel = nil
local characterJoints_Torso = nil
local characterJoints_Neck = nil
		
local function removeCharacterJoints(removeNeckJoint)

        if(characterJoints_Wheel~=nil) then
            display.remove(characterJoints_Wheel)
            characterJoints_Wheel=nil
        end
        
        if(characterJoints_Torso~=nil) then
            display.remove(characterJoints_Torso)
            characterJoints_Torso=nil
        end
	
	if removeNeckJoint==true then
            if(characterJoints_Neck~=nil) then
            
		display.remove(characterJoints_Neck)
                characterJoints_Neck=nil
            end
	end

end



function removeMouse()
    
    removeCharacterJoints(true)
    
    EraseAllTimers()

    display.remove(EyesSide)
    EyesSide=nil
   
    display.remove(EyesFront)
    EyesFront=nil
    
    Front=nil
    EyesState=nil
    changeFaceTimers=nil
    changeEyesTimers=nil
    tail_shake=nil
    tail_shake_d=nil
    moveto=nil
    timeFromDirectionChange=nil
    ReadyToTurn=nil
    MouseJumpForce=nil
    MouseFeerForce=nil
    turnTimer=nil
    mouseVisorTimer=nil
    mouseJumpTimer=nil
    mouseJumpTimer2=nil
    character_Xoffsets=nil
    character_Yoffsets=nil
    leg=nil
    leg_max=nil
    display.remove(head)
    head=nil
    display.remove(neck)
    neck=nil
    display.remove(torso)
    torso=nil
    display.remove(wheel)
    wheel=nil
    display.remove(leg_back)
    leg_back=nil
    display.remove(arm_back)
    arm_back=nil
    display.remove(tail)
    tail=nil

    display.remove(character)
    character=nil
    

end



local function UpdateEyes()

    if Front then

        EyesSide.isVisible=false
        EyesFront:stopAtFrame(EyesState)
        EyesFront.y=head.y+5
        EyesFront.x=head.x--*head.xScale
        EyesFront.xScale=head.xScale
        EyesFront.rotation=head.rotation
        EyesFront.isVisible=true
    else

        EyesFront.isVisible=false
        EyesSide:stopAtFrame(EyesState)
        EyesSide.y=head.y+7-5
        EyesSide.x=head.x+5*head.xScale
        EyesSide.xScale=head.xScale
        EyesSide.rotation=0--head.rotation
        EyesSide.isVisible=true
    end
end

local function createCharacterJoints(startX,startY,side,createNeckJoint)

	characterJoints_Wheel = physics.newJoint ( "pivot",  torso, wheel, startX,startY+character_Yoffsets.wheel)
	characterJoints_Wheel.isLimitEnabled =false
	characterJoints_Torso = physics.newJoint ( "pivot", torso, neck, startX, startY+15)--character_Yoffsets.torso-torso.height*0.5
	characterJoints_Torso.isLimitEnabled = true
	characterJoints_Torso:setRotationLimits( -5, 5)
	
	if createNeckJoint==true then
		characterJoints_Neck = physics.newJoint ( "pivot", neck, head, startX, startY+character_Yoffsets.head)--+character_Yoffsets.neck
		characterJoints_Neck.isLimitEnabled = true
		characterJoints_Neck:setRotationLimits (3, -3)
	end
        UpdateMiceVisor()
end

local function PrepareEyes(self)
    
    local folder="src/images/mouse/"
    EyesState=1
    Front=false

    --EyesSide = movieclip.newAnim({ folder.."manny_eyes_1.png", folder.."manny_eyes_2.png", folder.."manny_eyes_3.png"},6,10)
    --EyesFront = movieclip.newAnim({  folder.."manny_eyes_f1.png", folder.."manny_eyes_f2.png", folder.."manny_eyes_f3.png"},16,10)
	
	EyesSide = movieclip.newAnim({ folder.."manny_eyes_1.png", folder.."manny_eyes_2.png", folder.."manny_eyes_3.png"},6,10,0.5,1)
    EyesFront = movieclip.newAnim({  folder.."manny_eyes_f1.png", folder.."manny_eyes_f2.png", folder.."manny_eyes_f3.png"},16,10,0.5,1)
	
	
    
    EyesSide.isVisible = false;
    EyesFront.isVisible = false;
    character:insert (EyesSide)
    character:insert (EyesFront)
end



function CreateMouse(self,originX, originY, model) 
    isMouseOk   =true
    changeFaceTimers={}
    changeEyesTimers={}
    tail_shake=0
    tail_shake_d=1
    moveto=0
    timeFromDirectionChange=0
    ReadyToTurn=false
    MouseJumpForce=0
    MouseFeerForce=0
    character_Xoffsets={}
    character_Yoffsets={}
    leg=1
    leg_max=0


    local folder="src/images/mouse/"
    local prefix=""

    if model=="scotty" then 
		character_Xoffsets={leg_back=1, arm_back=0, tail=-8, torso=0, neck=0, head=0,leg_front=-2,arm_front=0,wheel=0}
		character_Yoffsets={leg_back=36, arm_back=0, tail=30, torso=25, neck=20, head=0,leg_front=40,arm_front=0,wheel=44}
		prefix="_right"

    elseif model=="manny" then
		character_Xoffsets={leg_back=1, arm_back=0, tail=-4, torso=0, neck=1, head=0,leg_front=-2,arm_front=0,wheel=0}
		character_Yoffsets={leg_back=41, arm_back=0, tail=30, torso=30, neck=24, head=-3,leg_front=45,arm_front=0,wheel=49}
	end

	character = display.newGroup ()
	 
	local startX = originX
	local startY = originY
	
	move_to=0
	leg = 1
	leg_max=0
	-- 0 no move
	-- 1 to right
	-- 2 to left
	

-- Leg Back
	leg_back = display.newImageRect(folder..model.."_leg_front_stand"..prefix..".png",16,20 )
	leg_back.anchorY=0;
	leg_back.anchorY = 0
	
	leg_back.x = startX+character_Xoffsets.leg_back
	leg_back.y = startY+character_Yoffsets.leg_back
	
	game:insert (leg_back)

-- Arm Back
	arm_back = display.newImageRect(folder..model.."_arm_back"..prefix..".png",30,10 )
	arm_back.anchorX=0;
	
	arm_back.anchorX = 0
	
	arm_back.x = startX+character_Xoffsets.arm_back
	arm_back.y = startY+character_Yoffsets.arm_back
	
	character:insert (arm_back)

-- Tail
	tail = display.newImageRect(folder..model.."_tail"..prefix..".png",18,42 )
	tail.anchorY=1;
    tail.anchorX=1;
	
	tail.anchorX = 18
	tail.anchorY = 42
	
	tail.x = startX+character_Xoffsets.tail
	tail.y = startY+character_Yoffsets.tail
	
	character:insert (tail)

	-- Torso
	torso = display.newImageRect(folder..model.."_torso"..prefix..".png",22,26 )
	torso.x = startX+character_Xoffsets.torso
	torso.y = startY+character_Yoffsets.torso
	

	character:insert (torso)

	-- Neck
	neck = display.newImageRect(folder..model.."_neck"..prefix..".png",14,20 )
	neck.anchorY = 20
	
	neck.x = startX+character_Xoffsets.neck
	neck.y = startY+character_Yoffsets.neck
	
	character:insert (neck)

	-- Head
        local headFiles={}
        for i=1,7 do
            headFiles[i]=folder.."manny_head_"..i..".png"
        end
        for i=1,7 do
            headFiles[i+7]=folder.."manny_head_f"..i..".png"
        end
        
        head = movieclip.newAnim(headFiles,38,38)

	--head = display.newImage(  model.."_head"..prefix..".png" )
	head.x = startX+character_Xoffsets.head
	head.y = startY+character_Yoffsets.head
	character:insert (head)

-- Leg Front
	leg_front = display.newImageRect(folder..model.."_leg_front_stand"..prefix..".png",16,20 )
	leg_front.anchorY = 0
	
	leg_front.x = startX+character_Xoffsets.leg_front
	leg_front.y = startY+character_Yoffsets.leg_front
	character:insert (leg_front)

-- Arm Front
	arm_front = display.newImageRect(folder..model.."_arm_front"..prefix..".png",30,10 )
	arm_front.anchorX = 0
	
	arm_front.x = startX+character_Xoffsets.arm_front
	arm_front.y = startY+character_Yoffsets.arm_front
	--arm_front.myName="character"
	character:insert (arm_front)
	
	


	local wheel_r=7

	wheel = display.newCircle( 0, 0, wheel_r )
	wheel.x = startX+character_Xoffsets.wheel
	wheel.y = startY+character_Yoffsets.wheel
	wheel:setFillColor(0,0,0,0)
	
	character:insert (wheel)
	
	local d=1
        local e=0.1
        local f=0.4
	
	head.myName="character"
	physics.addBody (head, {bounce = e, density=1, friction=f, radius = 18})
	neck.myName="character"
	physics.addBody (neck, {bounce = e, density=1, friction = f})
	torso.myName="character"
	physics.addBody (torso, {bounce = 0, density=1, friction = f, shape={-11,-11,11,-11,0,11} })
	torso.isFixedRotation = true
	
	wheel.myName="character"
	physics.addBody (wheel, { bounce = 1, density=15, friction=f, radius = wheel_r})

	createCharacterJoints(startX,startY,1,true)
	
	wheel.isBullet=true

    PrepareEyes()

	return character
end




function EraseAllTimers()
    if(mousecharacter.wheel==nil or mousecharacter.wheel.x==nil) then
            return 
    end
    
    if turnTimer~=nil then
        timer.cancel( turnTimer ) 
        turnTimer=nil
    end
    
    if mouseVisorTimer~=nil then
        timer.cancel(mouseVisorTimer);
        mouseVisorTimer=nil
    end
    
    if mouseJumpTimer~=nil then
        timer.cancel(mouseJumpTimer);
        mouseJumpTimer=nil
    end
    
    if mouseJumpTimer2~=nil then
        timer.cancel(mouseJumpTimer2);
        mouseJumpTimer2=nil
    end
    
    for i=1, #changeEyesTimers do
            timer.cancel( changeEyesTimers[i] ) 
            changeEyesTimers[i]=nil
    end
    changeEyesTimers={}
    
    for i=1, #changeFaceTimers do
            timer.cancel( changeFaceTimers[i] ) 
            changeFaceTimers[i]=nil
    end
    changeFaceTimers={}
end


local function getsign(x)
    if(x>=0) then
        return 1;
    else
        return -1;
    end
end
                  ---------------------------------------------------------  end of move me function

function RemoveMiceVisor(self)
    if mouseVisorTimer~=nil then
        timer.cancel(mouseVisorTimer);
        mouseVisorTimer=nil
    end
	
    display.remove(MiceVisor)
    MiceVisor=nil
end



local function onMiceVisorCollision( self, event )
	if buttons.physics_paused then
            return
        end

        if ( event.phase == "began" ) then
            
            --local toDo =  function()
            
            local eom=event.other.myName
            
            local JumpOnIt=false
            if(eom~="character" and eom~="Wall"  and eom~="TrapLeg" and  eom~="TrapM" and eom~="InsideTrap") then
                if eom=="CloseWall" and not MouseJumpsOnCloseWall then
                    JumpOnIt=false
                else
                    JumpOnIt=true
                end
                    
            else
                JumpOnIt=false
            end
                            
            if(eom=="Wall") then



            elseif(eom=="TrapLeg") then
                -- Fear of Trap
                if(MouseFeerForce>0 and world.TrapIsOpen) then
                    changeFace(nil,0,300,{5,4,3,2,6,1})

                    local distance2sensor=wheel.x-world.TrapLeg.x
                    local FearForce=getsign(distance2sensor)*MouseFeerForce
                    wheel:applyForce(FearForce,FearForce, wheel.x, wheel.y)--
                end

                
            elseif(JumpOnIt and world.TrapIsOpen) then
                if eom=="body" then
                    local s=world.WorldSprites[CheeseIndex]
                    local attraction=sprite_collection.SpriteColection[event.other.typeIndex].attraction
                    if attraction~=nil then

                        thegame:EatCheese(event.other.bodyIndex,attraction)
                        MiceVisor:removeEventListener( "collision",MiceVisor)

                        display.remove(MiceVisor)
                        MiceVisor=nil
        
                        if mouseVisorTimer~=nil then
                            timer.cancel(mouseVisorTimer);
                            mouseVisorTimer=nil
                        end
                        mouseVisorTimer=timer.performWithDelay(1000,UpdateMiceVisor,1)
                        MiceVisorState=MiceVisorState+1
                
                        return 
                    end
                    
                end

                local myclosure1= function() 
                    wheel:applyForce(0,MouseJumpForce, wheel.x, wheel.y)
                end
                
                if mouseJumpTimer~=nil then
                       timer.cancel(mouseJumpTimer);
                       mouseJumpTimer=nil
                end
                mouseJumpTimer=timer.performWithDelay(1,myclosure1,1)

                local vx,vy=wheel:getLinearVelocity()
                
                if vx<20 then
                    local myclosure2= function() 
                        wheel:applyForce(torso.xScale*(MouseJumpForce*0.5),0, wheel.x, wheel.y)
                    end
                    
                    
                    if mouseJumpTimer2~=nil then
                        timer.cancel(mouseJumpTimer2);
                        mouseJumpTimer2=nil
                    end
                    
                    mouseJumpTimer2=timer.performWithDelay(10,myclosure2,2)
               end
                
                        if(thegame.PlaySound) then      
                            local availableChannel = audio.findFreeChannel()
                            local index=math.random( #thegame.mouseJumpSounds )
                            audio.setVolume( MouseJumpForce/800, { channel=availableChannel } )
                            audio.play( thegame.mouseJumpSounds[index], { channel=availableChannel } )
                        end

                MiceVisor:removeEventListener( "collision",MiceVisor)
                display.remove(MiceVisor)
                MiceVisor=nil
        
                if mouseVisorTimer~=nil then
                    timer.cancel(mouseVisorTimer);
                    mouseVisorTimer=nil
                end
                mouseVisorTimer=timer.performWithDelay(1000,UpdateMiceVisor,1)
                MiceVisorState=MiceVisorState+1
                
                --end
                --timer.performWithDelay(10,toDo,1)
                
            end
        elseif ( event.phase == "ended" ) then
 

        end
end

function UpdateMiceVisor(self)
        if buttons.physics_paused then
            return
        end
    
        RemoveMiceVisor(nil)
        
        if(MiceVisorState==nil) then
            MiceVisorState=0
        end
        
        if(MiceVisorState==2) then
            
            MiceVisorState=0
            wheel:applyForce(0,MouseJumpForce, wheel.x, wheel.y)--torso.xScale*10
        end
        
        if(MiceVisorState==10 and thegame.CheeseIndex==-1) then
            
            MiceVisorState=0

            TurnCharacter(nil,-torso.xScale,true)

        else
        
            MiceVisor=display.newRect(0, 0, 5, 30)
			MiceVisor.anchorY = 30
	
            MiceVisor:setFillColor(0, 255,255, 0)
            game:insert(MiceVisor)
            MiceVisor.x=0
            MiceVisor.y=0
            MiceVisor.myName="MiceVisor"
            physics.addBody (MiceVisor,{ isSensor = true })
            MiceVisor.collision = onMiceVisorCollision
            MiceVisor:addEventListener( "collision", MiceVisor )
       end
end




function TurnCharacter(self,TurnTo,ChangeFace)
   
    if buttons.physics_paused then
        return
    end
    
    
    if torso.xScale==TurnTo or ReadyToTurn then
		return false
    end
        
    ReadyToTurn=true

    if turnTimer~=nil then
        timer.cancel( turnTimer ) 
        turnTimer=nil
    end    
    local myclosure= function() DoTurnCharacter(TurnTo); end
    turnTimer=timer.performWithDelay(200,myclosure,1)
    
    if(ChangeFace) then
        changeFace(nil,0,100,{11,10,4,1})    
    end
end


local function ChangeLeg(self)
       
	if buttons.physics_paused then
        return
    end

	if(wheel.angularVelocity>50) then

		local m=math.sin(math.rad(leg_front.rotation))
		if(leg==1) then
			if(m<leg_max) then
				--change leg
				leg=0
			else
				leg_max=m
			end
		else
			if(m>leg_max) then
				--change leg
				leg=1
			else
				leg_max=m
			end
		end
	end -- of: if(wheel.angularVelocity>100) then
	
	
end --of function

function MoveCharacter(self)
    if(mousecharacter.wheel==nil or mousecharacter.wheel.x==nil) then
            return false;
    end
    if(buttons.physics_paused)then
        return false;
    end   
    
    thegame:setArrowX()
    
    local vx,vy=wheel:getLinearVelocity()
    
    if math.abs(wheel.angularVelocity)<1 then
        
        --wheel:setLinearVelocity( 0,y )
        wheel.angularVelocity=0
    end 

    if(getsign(vx)~=torso.xScale) then
        --moving to another direction
        if math.abs(vx)>100 then
                -- turn body
                 TurnCharacter(nil,getsign(vx),true)
        else
            if timeFromDirectionChange==0 then
                -- Just started to move in wrong direction
                timeFromDirectionChange=system.getTimer()
            end
            
            if system.getTimer()-timeFromDirectionChange>2000 then
                --moving in wrong direction for more than 2sec
                -- turn body
                TurnCharacter(nil,getsign(vx),true)
                timeFromDirectionChange=0
            end
        end
        
    end


	if world.TrapImage~=nil and world.TrapDirection~=nil  then 
		world.TrapImage.x=world.WorldSprites[world.TrapBodyIndex].x
		world.TrapImage.y=world.WorldSprites[world.TrapBodyIndex].y
		world.TrapImage.rotation=world.WorldSprites[world.TrapBodyIndex].rotation--*world.TrapDirection
		
			if world.TrapSensor~=nil then 
				world.TrapSensor.x=world.WorldSprites[world.TrapBodyIndex].x
				world.TrapSensor.y=world.WorldSprites[world.TrapBodyIndex].y+10
				world.TrapSensor.rotation=world.WorldSprites[world.TrapBodyIndex].rotation
			end
	end
			
			
	if world.TrapIsOpen==true and world.TrapStick~=nil and world.TrapDirection~=nil then 
		world.TrapStick.x=world.TrapLeg.x+25*world.TrapDirection
		world.TrapStick.y=world.TrapLeg.y
		world.TrapStick.rotation=world.TrapLeg.rotation*world.TrapDirection
		
	end
                                
        if(MiceVisor~=nil) then
            if(MiceVisor.x~=nil) then
                MiceVisor.y= wheel.y+7---wheel.radius
                MiceVisor.x= wheel.x+20*torso.xScale
            end
        end

	head:applyForce( 0,-3, head.x, head.y)

	if(move_to==1) then
		wheel:applyForce( 20,0, wheel.x, wheel.y)
	end
	
	

	if(move_to==2) then
		wheel:applyForce( -20,0, wheel.x, wheel.y)
	end
	
	if(move_to==-1) then
		local vx, vy = wheel:getLinearVelocity()
		
		if(vx>10) then
			wheel:applyForce( -20,0, wheel.x, wheel.y)
			wheel.angularVelocity=0
		else
			obj.move_to=0
		end
		
	end
	
	if(move_to==-2) then
		local vx, vy = wheel:getLinearVelocity()
		
		if(vx<10) then
			wheel:applyForce(20,0, wheel.x, wheel.y)
			wheel.angularVelocity=0
		else
			move_to=0
		end

	end

        UpdateEyes();

        
            
        if thegame.CameraWatch~=3 then
            
            if(world.TrapSensor~=nil and world.TrapSensor.x~=nil) then
            
                local dx=math.abs(wheel.x-world.TrapImage.x)
                local dy=math.abs(wheel.y-(world.TrapImage.y+53))
            
                if dx<200 and dy<10 then
                    thegame.CameraWatch=3
                    buttons:CreateCameraButton()
                end
            
            end
        end

local s=math.sin(math.rad(wheel.rotation))
local r=s*(wheel.angularVelocity/10+5)--where 7 is leg angle cooficient

local s2=math.sin(math.rad(wheel.rotation*0.5))
local r2=s2*(wheel.angularVelocity/10+5)--where 7 is leg angle cooficient

local max_leg_angle=70

if(r>max_leg_angle) then
	r=max_leg_angle
end
	
if(r<-max_leg_angle) then
	r=-max_leg_angle
end
	
local x=wheel.x--+game.x

ChangeLeg(r)


local kx=2
local ky=7
local leg_d=1

-- legs

leg_back.x=x+1-kx
leg_back.y=wheel.y-7-ky+leg_d-leg_d*leg
leg_back.rotation=-r

leg_front.x=x-2-kx
leg_front.y=wheel.y-6-ky+leg_d*leg
leg_front.rotation=r

-- arms
local ar=r2*1.5
local max_arm_angle=50

if(ar>max_arm_angle) then
	ar=max_arm_angle
end
	
if(ar<-max_arm_angle) then
	ar=-max_arm_angle
end



arm_back.x=torso.x+1
arm_back.y=torso.y-13
arm_back.rotation=-ar+90*torso.xScale

arm_front.x=torso.x+1
arm_front.y=torso.y-13
arm_front.rotation=ar+2+90*torso.xScale


if torso.xScale==1 then
	--tail.x=torso.x-(torso.width*0.5)
        tail.x=torso.x+character_Xoffsets.tail
else
    
	--tail.x=torso.x+(torso.width*0.5)
        tail.x=torso.x-character_Xoffsets.tail
end
tail.y=torso.y+torso.height*0.5
local shake_level=math.abs(math.floor(wheel.angularVelocity/100))+1

--if shake_level==0 then
	

tail_shake=tail_shake+tail_shake_d
if tail_shake>shake_level or tail_shake<-shake_level then
tail_shake_d=-tail_shake_d
end

local tailAngle=math.floor(wheel.angularVelocity/50)


if tailAngle>25 then
	tailAngle=25
end

if tailAngle<-25 then
	tailAngle=-25
end
--tail_shake+
tail.rotation=-tailAngle+(15)*torso.xScale
        
--end -- if        
end --         END    

function StopMouse(self)
    --wheel:setLinearVelocity( 0,0 )
    --wheel.angularVelocity=0
    
    wheel:setLinearVelocity( 0,0 )
    wheel.angularVelocity=0
                        
    torso:setLinearVelocity( 0,0 )
    torso.angularVelocity=0
                        
    neck:setLinearVelocity( 0,0 )
    neck.angularVelocity=0
                        
    head:setLinearVelocity( 0,0 )
    head.angularVelocity=0
end

function RunForCheese(self,CheeseIndex)
    local s=world.WorldSprites[CheeseIndex]
    local attraction=sprite_collection.SpriteColection[s.typeIndex].attraction
    local dx=(s.x-wheel.x)/500*attraction

    TurnCharacter(nil,getsign(dx),false)
    wheel:applyForce(dx,0, wheel.x, wheel.y)
end



function changeEyes(self,delay,speed,sequence)
    
  
    
    
    for i=1, #changeEyesTimers do
            timer.cancel( changeEyesTimers[i] ) 
            changeEyesTimers[i]=nil
    end
    changeEyesTimers={}
    local myclosure={}

    for i,line in ipairs(sequence) do
        
        if(sequence[i]>0 and sequence[i]<4) then
            
            local index=sequence[i]

            myclosure[i]= function() EyesSide:stopAtFrame(index);EyesState=index;Front=false; end
            changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay+(i-1)*speed,myclosure[i],1)
        end
        
        if(sequence[i]>3 and sequence[i]<7) then
            local index=sequence[i]-3

            myclosure[i]= function() EyesFront:stopAtFrame(index);EyesState=index;Front=true; end
            changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay+(i-1)*speed,myclosure[i],1)
        end
        
    end

end

function blinkEyes(self)

    
    
    changeEyes(nil,0,100,{1,2,3,2,1})
end

function changeFaceAnySide(self,delay,speed,sequence,front_)

    
    for i=1, #changeFaceTimers do
            timer.cancel( changeFaceTimers[i] ) 
            changeFaceTimers[i]=nil
    end
    changeFaceTimers={}
    
    local myclosure={}
    for i,line in ipairs(sequence) do
        
        if(sequence[i]>0 and sequence[i]<8) then
            local index=sequence[i]
            if(front_)then
                index=index+7
            end
            myclosure[i]= function() head:stopAtFrame(index);if index>7 then Front=true else Front=false end end
            changeFaceTimers[#changeFaceTimers+1]=timer.performWithDelay(delay+(i-1)*speed,myclosure[i],1)
        end
    end

end

function changeFace(self,delay,speed,sequence)
        

        
    for i=1, #changeFaceTimers do
            timer.cancel( changeFaceTimers[i] ) 
            changeFaceTimers[i]=nil
    end
    changeFaceTimers={}
    
    local myclosure={}
    for i,line in ipairs(sequence) do
        
        if(sequence[i]>0 and sequence[i]<15) then
            local index=sequence[i]

            myclosure[i]= function() 
                head:stopAtFrame(index);
                if index>7 then 
                    Front=true
                else
                    Front=false
                end
            end
            changeFaceTimers[#changeFaceTimers+1]=timer.performWithDelay(delay+(i-1)*speed,myclosure[i],1)
        end
    end

end


function DoTurnCharacter(TurnTo)

        if buttons.physics_paused then
            return
        end

	
	local startX=wheel.x
	local startY=wheel.y-character_Yoffsets.wheel
		
	local s=TurnTo
	tail.xScale = s
	if TurnTo==1 then
		tail.anchorX = 18
		tail.anchorY = 42
	else
		tail.anchorX = 0
		tail.anchorY = 42
	end
	
	
	removeCharacterJoints(true)


			leg_back.xScale = s
			leg_back.x=startX+character_Xoffsets.leg_back*s
			
			arm_back.xScale = s
			arm_back.x=startX+character_Xoffsets.arm_back*s
			
			tail.xScale = s
			tail.x=startX+character_Xoffsets.tail*s
			tail.y=startY+character_Yoffsets.tail
			
			torso.xScale = s
			torso.x=startX+character_Xoffsets.torso*s
			torso.y=startY+character_Yoffsets.torso

			neck.xScale = s
			neck.x=startX+character_Xoffsets.neck*s
			neck.y=startY+character_Yoffsets.neck
			
			head.xScale = s
			head.x=startX+character_Xoffsets.head*s
			head.y=startY+character_Yoffsets.head
			
			leg_front.xScale = s
			leg_front.x=startX+character_Xoffsets.leg_front*s
			
			arm_front.xScale = s
			arm_front.x=startX+character_Xoffsets.arm_front*s
	
			--tail.rotation=-20*s
			neck.rotation=0
			head.rotation=0
			
	createCharacterJoints(startX,startY,TurnTo,true)
        
        
        ReadyToTurn=false
end
