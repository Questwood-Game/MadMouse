--==================================================================================================
-- 
-- Abstract: MadMouse 
-- 
--==================================================================================================

--
-- Project: inmobi.lua
-- Description: 
--
-- Version: 1.0
-- Ivan Komlev, Copyright 2013 . All Rights Reserved.
-- 
module(..., package.seeall)



local bgW, bgH = 320, 48
local currentAdIndex = 1

local adsTable = {
	"banner320x48"
}
local bgW, bgH = 320, 48

local backgroundImg=nil

function PrepareAds()
    local adNetwork = "inmobi"
    local appID = "101e04cd2ab34fa8bf33027b3bad68b5" -- inmobi
    ads.init( adNetwork, appID )
end

function ShowAd(self)

    
    
    local adX, adY = display.contentWidth*0.5-bgW*0.5, display.contentHeight-bgH
    -- create a background for the app
    
    --backgroundImg = display.newRect( 0,0, bgW, bgH )
    --backgroundImg:setFillColor(0,0,0,20)
    --backgroundImg:setReferencePoint( display.TopLeftReferencePoint )
    --backgroundImg.x, backgroundImg.y = adX, adY
    local sysEnv = system.getInfo("environment")
    if sysEnv == "simulator" then
        return
    end
    
    ads.show( adsTable[currentAdIndex], { x=adX, y=adY, interval=5, testMode=false } )

end

function HideAd(self)
    ads.hide()

end
    

