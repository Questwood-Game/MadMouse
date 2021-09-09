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

Finger=nil
local FingerShadow=nil
local StartX=0
local StartY=0
local dX=-2--
local dY=-4--10

local timerId={}

local AllTransition={}

local function CancelAllTransition()

    for i=1, #AllTransition  do
        transition.cancel(AllTransition[i])
        AllTransition[i]=nil
    end
    i=nil
    AllTransition={}
end
-- ---------

function drawFinger(self,x,y)
    CancelAllTransition()
    StartX  = x
    StartY  = y
        
    FingerShadow = display.newImageRect( "src/images/misc/finger.png",68,76)
    FingerShadow:setFillColor(0, 0,0, 100)
    FingerShadow.x=x-dX
    FingerShadow.y=y-dY
        
    Finger = display.newImageRect( "src/images/misc/finger.png",68,76)
    Finger.x=x
    Finger.y=y
end

function DoMoveTo(x,y,scale_from,scale_to,speed)
    CancelAllTransition()
    AllTransition[#AllTransition+1]=transition.to( FingerShadow, {delay=0, time=speed+50, x=x-dX, y=y-dY,  xScale=scale_from,yScale=scale_from} )
    AllTransition[#AllTransition+1]=transition.to( Finger, {delay=0, time=speed, x=x, y=y,                  xScale=scale_from,yScale=scale_from} )
    AllTransition[#AllTransition+1]=transition.to( FingerShadow, {delay=speed+200, time=200, x=x-dX, y=y-dY,      xScale=scale_to,yScale=scale_to} )
    AllTransition[#AllTransition+1]=transition.to( Finger, {delay=speed+200, time=200, x=x, y=y,                  xScale=scale_to,yScale=scale_to} )
end


function moveTo(self,x,y,delay,scale_from,scale_to,speed)

    local myclosure= function() DoMoveTo(x,y,scale_from,scale_to,speed); end
    timerId[#timerId+1]=timer.performWithDelay(delay,myclosure,1)
end

function doRemoveMe(self)
    CancelAllTransition()
    for i=1, #timerId do
        timer.cancel( timerId[i] ) 
        timerId[i]=nil
    end
    timerId={}
    --if FingerShadow~=nil and FingerShadow.x~=nil then
    
    display.remove(FingerShadow)
    FingerShadow=nil
    
    --if Finger~=nil and Finger.x~=nil then
    
    display.remove(Finger)
    Finger=nil
    
end

function removeMe(self,delay)
    timerId[#timerId+1]=timer.performWithDelay(delay,doRemoveMe,1)
end




