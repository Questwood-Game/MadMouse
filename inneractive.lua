--==================================================================================================
-- 
-- Abstract: MadMouse 
-- 
--==================================================================================================

--
-- Project: inneractive.lua
-- Description: 
--
-- Version: 1.0
-- Ivan Komlev, Copyright 2013 . All Rights Reserved.
-- 
module(..., package.seeall)


-- Below is the ad network that will be used:



local ads = require "ads"
--local statusText=nil
--==================================================================================================


local function adListener( event )
	-- event table includes:
	-- 		event.provider (e.g. "inneractive")
	--		event.isError (e.g. true/false )
	
	if event.isError then
		--statusText:setTextColor( 255, 0, 0 )
		--statusText.text = "Error Loading Ad"
		--statusText.x = display.contentWidth * 0.5
	else
		--statusText:setTextColor( 0, 255, 0 )
		--statusText.text = "Successfully Loaded Ad"
		--statusText.x = display.contentWidth * 0.5
	end
end





function PrepareAds(self)
    local adNetwork = "inneractive"
    local appID = "DesignCompass_MadMouse_Android"
    -- Create a text object to display ad status
    --statusText = display.newText( "", 0, 0, native.systemFontBold, 22 )
    --statusText:setTextColor( 255 )
    --statusText:setReferencePoint( display.CenterReferencePoint )
    --statusText.x, statusText.y = display.contentWidth * 0.5, 160

    -- Set up ad listener.
    -- initialize ad network:
    ads.init( adNetwork, appID, adListener )
    --statusText:toFront()
end


function ShowAd(self,adType)
        local sysEnv = system.getInfo("environment")
  --      if sysEnv == "simulator" then
--            print ("Only For Device")
          --  return 
        --end
        local bgW, bgH = 320, 24
        --local adX, adY = display.contentWidth*0.5-bgW*0.5, 
        
        -- create a background for the app
        --backgroundImg = display.newRect( 0,0, bgW, bgH )
        --backgroundImg:setFillColor(250,0,0,100)
        --backgroundImg:setReferencePoint( display.TopLeftReferencePoint )
        --backgroundImg.x, backgroundImg.y = adX, adY
        --print ("adType="..adType);
        if adType==nil then
            adType="banner" --posible values: text, banner, fullscreen    
        end
        
        
        if adType=="banner" then
            bgH=60
        end
        
	local adX, adY = 0, display.contentHeight-bgH
	--statusText.text = ""
	ads.show( adType, { x=adX, y=adY, interval=30, testMode=false } )	-- standard interval for "inneractive" is 60 seconds
end

function HideAd(self)
    ads.hide()

end


