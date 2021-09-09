--
-- Project: main.lua
-- Description: 
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 . All Rights Reserved.
-- 
module(..., package.seeall)

local CharacterX=0
local CharacterY=0

local Torso
local Neck
local Face
local Face_FrontEyes
local Face_SideEyes

local Face_FrontEyebrows
local Waist
local UpperLeg1
local UpperLeg2
local LowerLeg1
local LowerLeg2

local bodyDirection=-1
local headDirection=-1

local xOffsets
local yOffsets

local CurrentFace

local Front
local changeFaceTimers={}
local changeEyesTimers={}
local BodyTurnTimers={}

local AllTransition={}

local function CancelAllTransition()
    
	for i=1, #AllTransition  do
        transition.cancel(AllTransition[i])
        AllTransition[i]=nil
    end
	
    i=nil
    AllTransition={}
end

function EraseAllTimers()

    CancelAllTransition()
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
    
    for i=1, #BodyTurnTimers do
            timer.cancel( BodyTurnTimers[i] ) 
            BodyTurnTimers[i]=nil
    end
    BodyTurnTimers={}
end


function removeCharacter(self)
    
    print("Remove Character (girl)")
    CancelAllTransition()
    display.remove(Torso)
    Torso=nil
    
    display.remove(Neck);
    Neck=nil
    
    
    display.remove(Face);
    Face=nil
    
    display.remove(Face_Eyes);
    Face_Eyes=nil
    
    display.remove(Face_Eyebrows);
    Face_Eyebrows=nil
    
    display.remove(Waist);
    Waist=nil
    
    display.remove(UpperLeg1);
    UpperLeg1=nil
    
    display.remove(UpperLeg2);
    UpperLeg2=nil
            
    display.remove(LowerLeg1);
    LowerLeg1=nil
    
    display.remove(LowerLeg2);
    LowerLeg2=nil
end

function drawCharacter(self,x,y)
    local folder="src/images/user/"
    Front=true
    CurrentFace=1
    bodyDirection=-1
    headDirection=-1
    
    CharacterX=x
    CharacterY=y
    
    xOffsets={face=7,face_r=3,faceeyes_front=-5,faceeyes_front_r=2,faceeyes_side=-11,faceeyes_side_r=11}
    yOffsets={face=-35,face_down=-32,face_up=-38,faceeyes_front=-34,faceeyes_front_down=-30,faceeyes_front_up=-36,faceeyes_side=-32,faceeyes_side_down=-30,faceeyes_side_up=-36}

    UpperLeg2 = display.newImageRect( folder.."user_lindsey_leg_upper2_front.png",12,19)
    UpperLeg2.anchorY = 0
    UpperLeg2.x=x-5
    UpperLeg2.y=y+10
    game:insert (UpperLeg2)
    
    LowerLeg2 = display.newImageRect( folder.."user_lindsey_leg_lower2_front.png",15,15)
    LowerLeg2.x=x-4
    LowerLeg2.y=y+30
    game:insert (LowerLeg2)
    

    
    Waist = display.newImageRect(folder.."user_lindsey_waist_front.png",20,13)
    Waist.x=x
    Waist.y=y+14
    game:insert (Waist)
    
    UpperLeg1 = display.newImageRect( folder.."user_lindsey_leg_upper1_front.png",13,16)
    UpperLeg1.anchorY = 0
    UpperLeg1.x=x+8
    UpperLeg1.y=UpperLeg2.y+5
    game:insert (UpperLeg1)
    
    LowerLeg1 = display.newImageRect( folder.."user_lindsey_leg_lower1_front.png",16,14)
    LowerLeg1.x=x+11
    LowerLeg1.y=y+30
    game:insert (LowerLeg1)
    
    
    ArmLeft = display.newImageRect( folder.."user_lindsey_arm_bent_fist2_front.png",22,19)
	ArmLeft.anchorX = 0
	ArmLeft.anchorY = 0
    ArmLeft.x=x
    ArmLeft.y=y-12
    ArmLeft.xScale=-1
    ArmLeft.rotation=0
    game:insert (ArmLeft)

    ArmRight = display.newImageRect( folder.."user_lindsey_arm_bent_fist2_front.png",22,19)
    
	ArmRight.anchorX = 22
	ArmRight.anchorY = 0
	
    ArmRight.x=x+27
    ArmRight.y=y-12
    ArmRight.xScale=1
    ArmRight.rotation=0
    game:insert (ArmRight)
    
    Torso = movieclip.newAnim({ folder.."user_lindsey_torso_front.png", folder.."user_lindsey_torso_side.png"},22,30)
    Torso.x=x
    Torso.y=y
    game:insert (Torso)
    
    Neck = display.newImageRect(folder.."user_lindsey_neck_front.png",8,13);
    
    Neck.x=x+4
    Neck.y=y-16
    game:insert (Neck)
    
    local Faces={}
    for i=1,7 do
        Faces[i]=folder.."user_lindsey_face_"..i.."_front.png"
    end
    
    for i=1,7 do
        Faces[i+7]=folder.."user_lindsey_face_"..i.."_side.png"
    end
    Face = movieclip.newAnim(Faces,72,44)    
    Face.x=x+xOffsets.face
    Face.y=y+yOffsets.face
    game:insert (Face)
    Face.isVisible = true;

    Face_FrontEyes = movieclip.newAnim({ folder.."user_lindsey_eyes_1_front.png",folder.."user_lindsey_eyes_2_front.png", folder.."user_lindsey_eyes_3_front.png" },26,14)
    Face_FrontEyes.x=Face.x+xOffsets.faceeyes_front
    Face_FrontEyes.y=y+yOffsets.faceeyes_front
    game:insert (Face_FrontEyes)
    Face_FrontEyes.isVisible = true;
    
    Face_SideEyes = movieclip.newAnim({ folder.."user_lindsey_eyes_1_side.png",folder.."user_lindsey_eyes_2_side.png", folder.."user_lindsey_eyes_3_side.png" },10,14)
    Face_SideEyes.x=Face.x+xOffsets.faceeyes_side
    Face_SideEyes.y=y+yOffsets.faceeyes_side
    game:insert (Face_SideEyes)
    Face_SideEyes.isVisible = false;
    
    FootSide = display.newImageRect( folder.."user_lindsey_foot_side_front.png",20,8)
    FootSide.x=x-7
    FootSide.y=y+39
    game:insert (FootSide)
    
    
    FootFront = display.newImageRect( folder.."user_lindsey_foot_front_front.png",19,10)
    FootFront.x=x+16
    FootFront.y=y+39
    game:insert (FootFront)
    FootFront.xScale=1

    bodyDirection=-1
    
end

function turnTorsoAndLegs2Right(self)
    turnTorsoAndLegs(1)
    if headDirection==1 then
        turnHead2Right()
    else
        turnHead2Left()
    end
end

function turnTorsoAndLegs2Left(self)
    turnTorsoAndLegs(-1)
    if headDirection==1 then
        turnHead2Right()
    else
        turnHead2Left()
    end
end

function turnTorsoAndLegs(sScale)
    if(Face==nil or Face.x==nil) then
            return 
    end
    -- sScale == -1 - to left
    -- sScale == 1 - to right
    local s=-sScale
    
    Torso.xScale=s
    if sScale==1 then
        Torso.x=CharacterX+4
    else
        Torso.x=CharacterX
    end
    
    UpperLeg2.xScale=s
    UpperLeg2.x=Torso.x-5*s
   
    LowerLeg2.xScale=s
    LowerLeg2.x=Torso.x-4*s
        
    Waist.xScale=s
    Waist.x=Torso.x
    
    UpperLeg1.xScale=s
    UpperLeg1.x=Torso.x+8*s
    
    LowerLeg1.xScale=s
    LowerLeg1.x=Torso.x+11*s
    

    
    
    Neck.xScale=s
    Neck.x=Torso.x+4*s
    
    FootSide.xScale=s
    
    --if sScale==1 then
        FootSide.x=Torso.x+7*sScale
    --else
      --  FootSide.x=Torso.x-7
    --end

    FootFront.xScale=s
    
    --if sScale==1 then
        FootFront.x=Torso.x-16*sScale
    --else
      --  FootFront.x=Torso.x+16*s
    --end
    
    bodyDirection=sScale
end

function turnHead2Right(self)
    if(Face==nil or Face.x==nil) then
            return 
    end
    
   Face.xScale=-1
   Face_FrontEyes.xScale=-1
   Face_SideEyes.xScale=-1
   if bodyDirection==-1 then
       --body turend to left
       Face.x=CharacterX+xOffsets.face_r
       Face_FrontEyes.x=Face.x+xOffsets.faceeyes_front_r
       Face_SideEyes.x=Face.x+xOffsets.faceeyes_side_r
   else
       --body turend to right
       Face.x=CharacterX-xOffsets.face_r
       Face_FrontEyes.x=Face.x+xOffsets.faceeyes_front_r
       Face_SideEyes.x=Face.x+xOffsets.faceeyes_side_r
   end
   headDirection=1--head turend to right
end

function turnHead2Left(self)
    if(Face==nil or Face.x==nil) then
            return 
    end
    
   Face.xScale=1
   Face_FrontEyes.xScale=1
   Face_SideEyes.xScale=1
   if bodyDirection==-1 then

       --body turend to right
       Face.x=CharacterX+xOffsets.face
       Face_FrontEyes.x=Face.x+xOffsets.faceeyes_front
       Face_SideEyes.x=Face.x+xOffsets.faceeyes_side
   else
       --body turend to left
       Face.x=CharacterX+xOffsets.face_r
       Face_FrontEyes.x=Face.x+xOffsets.faceeyes_front
       Face_SideEyes.x=Face.x+xOffsets.faceeyes_side
   end
   headDirection=-1 --head turend to left
end

function turnBody2Right(self)
    for i=1, #BodyTurnTimers do
            timer.cancel( BodyTurnTimers[i] ) 
            BodyTurnTimers[i]=nil
    end
    BodyTurnTimers={}
    BodyTurnTimers[#BodyTurnTimers+1]=timer.performWithDelay(0,turnHead2Right,1)
    BodyTurnTimers[#BodyTurnTimers+1]=timer.performWithDelay(100,turnTorsoAndLegs2Right,1)
    
end

function turnBody2Left(self)
    for i=1, #BodyTurnTimers do
            timer.cancel( BodyTurnTimers[i] ) 
            BodyTurnTimers[i]=nil
    end
    BodyTurnTimers={}
    BodyTurnTimers[#BodyTurnTimers+1]=timer.performWithDelay(300,turnHead2Left,1)
    BodyTurnTimers[#BodyTurnTimers+1]=timer.performWithDelay(400,turnTorsoAndLegs2Left,1)
    
end


function moveHeadDown(self,DoDelay,speed)
    --Move head down
    AllTransition[#AllTransition+1]=transition.to( Face, {delay=DoDelay, time=speed, y=CharacterY+yOffsets.face_down } )
    if Front then
        AllTransition[#AllTransition+1]=transition.to( Face_FrontEyes, {delay=DoDelay, time=speed+10, y=CharacterY+yOffsets.faceeyes_front_down } )
    else
        AllTransition[#AllTransition+1]=transition.to( Face_SideEyes, {delay=DoDelay, time=speed+10, y=CharacterY+yOffsets.faceeyes_side_down } )        
    end
end

function moveHeadUp(self,DoDelay,speed)
    AllTransition[#AllTransition+1]=transition.to( Face, {delay=DoDelay, time=speed, y=CharacterY+yOffsets.face_up } )
    if Front then
        AllTransition[#AllTransition+1]=transition.to( Face_FrontEyes, {delay=DoDelay, time=speed+10, y=CharacterY+yOffsets.faceeyes_front_up } )
    else
        AllTransition[#AllTransition+1]=transition.to( Face_SideEyes, {delay=DoDelay, time=speed+10, y=CharacterY+yOffsets.faceeyes_side_up } )
    end
end

function moveHead2Normal(self,DoDelay,speed)
    --Move head to normal
    AllTransition[#AllTransition+1]=transition.to( Face, {delay=DoDelay, time=speed, y=CharacterY+yOffsets.face } )
    if Front then
        AllTransition[#AllTransition+1]=transition.to( Face_FrontEyes, {delay=DoDelay, time=speed+10, y=CharacterY+yOffsets.faceeyes_front } ) 
    else
        AllTransition[#AllTransition+1]=transition.to( Face_SideEyes, {delay=DoDelay, time=speed+10, y=CharacterY+yOffsets.faceeyes_side } ) 
    end
end

function SetEyes_Open()
    if Front then
        Face_FrontEyes:stopAtFrame(1)
    else
        Face_SideEyes:stopAtFrame(1)
    end
end

function SetEyes_HalfOpen()
    if Front then
        Face_FrontEyes:stopAtFrame(2)
    else
        Face_SideEyes:stopAtFrame(2)
    end
end

function SetEyes_Closed()
    if Front then
        Face_FrontEyes:stopAtFrame(3)
    else
        Face_SideEyes:stopAtFrame(3)
    end
end

function closeEyes(self,delay,speed)
    changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay,SetEyes_HalfOpen,1)
    changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay+speed,SetEyes_Closed,1)
end

function openEyes(self,delay,speed)
    changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay,SetEyes_HalfOpen,1)
    changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay+speed,SetEyes_Open,1)
end

function blinkEyes(self,delay,speed,stayclosedtime)
    for i=1, #changeEyesTimers do
            timer.cancel( changeEyesTimers[i] ) 
            changeEyesTimers[i]=nil
    end
    changeEyesTimers={}
    
    changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay,SetEyes_HalfOpen,1)
    changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay+speed,SetEyes_Closed,1)
    
    changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay+speed*2+stayclosedtime,SetEyes_HalfOpen,1)
    changeEyesTimers[#changeEyesTimers+1]=timer.performWithDelay(delay+speed*3+stayclosedtime,SetEyes_Open,1)
end

--function SetFaceAt(index)
  --  Face:stopAtFrame(index)
--end

function changeFace(self,delay,speed,sequence)
    if(Face==nil or Face.x==nil) then
            return 
    end
    
    
    for i=1, #changeEyesTimers do
            timer.cancel( changeEyesTimers[i] ) 
            changeEyesTimers[i]=false
    end
    changeEyesTimers={}
    for i=1, #changeFaceTimers do
            timer.cancel( changeFaceTimers[i] ) 
            changeFaceTimers[i]=false
    end
    changeFaceTimers={}
    
    local myclosure={}
    for i,line in ipairs(sequence) do
        local index=sequence[i]
        if(index>0 and index<15) then
           
            myclosure[i]= function() 
                Face:stopAtFrame(index); 
                if index>7 then 
                    Front=false 
                    Face_FrontEyes.isVisible=false
                    Face_SideEyes.isVisible=true
                else
                    Front=true 
                    Face_SideEyes.isVisible=false
                    Face_FrontEyes.isVisible=true
                    
                end 
            end
            changeFaceTimers[#changeFaceTimers+1]=timer.performWithDelay(delay+(i-1)*speed,myclosure[i],1)
        end
    end

    --timer.performWithDelay(delay,SetEyes_HalfOpen,1)
    --timer.performWithDelay(delay+speed,SetEyes_Open,1)
end

function turnTorso2Side(self,delay,side)
    
    if(Face==nil or Face.x==nil) then
            return 
    end
    
    
    local myclosure= nil




    if side then
        myclosure= function() Torso:stopAtFrame(2); end
    else
        myclosure= function() Torso:stopAtFrame(1); end
    end
    BodyTurnTimers[#BodyTurnTimers+1]=timer.performWithDelay(delay,myclosure,1)
end
