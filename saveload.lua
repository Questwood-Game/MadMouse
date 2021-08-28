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
local str = require("str")


function saveLevel(void, filePath)

	 	
	 	local path=""
	 	if  system.getInfo( "environment" ) =="simulator" then
	 		path = filePath--system.pathForFile( filePath, system.ResourceDirectory )

	 	else
		 	path = system.pathForFile( filePath, system.DocumentsDirectory )
	 	end
	 	
        local file = io.open( path, "w" )
	        
        if file then 

        else

	        file= io.open( filePath, "w" )	
        end	
        	
        if file then 

        file:write('character,'..math.floor(mousecharacter.wheel.x)..','..math.floor(mousecharacter.wheel.y)..';')
        
        
		for i,line in ipairs(world.WorldSprites) do
			if world.WorldSprites[i].x~=nil then 
				local typeIndex=world.WorldSprites[i].typeIndex
				local t=sprite_collection.SpriteColection[typeIndex].type
				local title=sprite_collection.SpriteColection[typeIndex].title

                                local r=math.floor(world.WorldSprites[i].rotation)
                                local y=math.floor(world.WorldSprites[i].y)
                                if t=="trap" then

                                    r=0
                                    y=y-30
                                end
                                
                                local s=t..','..title..','..math.floor(world.WorldSprites[i].x)..','..y..','..r..';'

		
				file:write(s )
			end
            end
        

                io.close( file )
        else

        end
        

end


local function findSpriteByTitle(title)
			for i,line in ipairs(sprite_collection.SpriteColection) do
                            local s=sprite_collection.SpriteColection[i]
                            if s.title==title then
				return i
			end
		end
		return -1
end

function loadLevel(void, filePath, isLocal)

        
        local path = ""

	if  isLocal==true or system.getInfo( "environment" ) =="simulator" then
	 		path = filePath--system.pathForFile( filePath, system.ResourceDirectory )
	 else
		 	path = system.pathForFile( filePath, system.DocumentsDirectory )
	 end


        file = io.open( path, "r" )        
        
        if file then

 	           -- Read file contents into a string
                local dataStr = file:read( "*a" )
                

                world.WorldSprites={}
                
                
                
                -- Break string into separate variables and construct new table from resulting data
                
                loadLevelFromString(void, dataStr)
           
                io.close( file ) -- important!
     end  
end

function loadLevelFromString(void, dataStr)
        world.WorldSprites={}
        world.NumberOfItems=0
        world.NumberOfItemsUsed=0
        local CollisionFilter = { categoryBits = 1, maskBits = 5 } 

                local datavars = str.split(dataStr, ";")
 
                dataTableNew = {}
                
                for i = 1, #datavars do
                        -- split each name/value pair
                        local onevalue = str.split(datavars[i], ",")
                        if #onevalue>1 then
                            

                                if onevalue[1]=="user" then
                                    local userX=tonumber(onevalue[2])--x
                                    local userY=tonumber(onevalue[3])--y
                                    thegame.UserPositionX=userX
                                    thegame.UserPositionY=userY

                                    thegame.UserArmLength =tonumber(onevalue[5])--radius

                                    world:setUserSensor(userX,userY)
                                    
            
                                elseif onevalue[1]=="character" then

                                    local theMouse=mousecharacter:CreateMouse(onevalue[2],onevalue[3]-50, "manny")
                                    game:insert(theMouse)
                                    
                                    mousecharacter.MouseJumpForce=tonumber(onevalue[5])
                                    mousecharacter.MouseFeerForce=tonumber(onevalue[6])
                                    
                                    if(tonumber(onevalue[7])==1) then
                                        mousecharacter.MouseJumpsOnCloseWall=true
                                    else
                                        mousecharacter.MouseJumpsOnCloseWall=false
                                    end
                                    
                                    
                                    
                                    if(tonumber(onevalue[4])==-1) then
                                        mousecharacter:TurnCharacter(-1,true)
                                    end


	                        elseif onevalue[1]=='body' or onevalue[1]=='trap' then
	                        	local index=findSpriteByTitle(onevalue[2])
	                        	if index~=-1 then 

		                        	local s=sprite_collection.SpriteColection[index]
		                        	
		                        	if s.type=="trap" then

							world:dropTrap(s,index,onevalue[3],onevalue[4],onevalue[5],onevalue[6],onevalue[7])
                                                
                                                    
                                                elseif s.type=="body" then
                                                    
                                                                                world.NumberOfItems=world.NumberOfItems+1

										world.WorldSprites[#world.WorldSprites+1]=display.newImageRect( "src/images/sprites/"..s.image,s.width,s.height  )
										world.WorldSprites[#world.WorldSprites]:setReferencePoint( display.CenterCenterReferencePoint)
										game:insert(world.WorldSprites[#world.WorldSprites])
										world.WorldSprites[#world.WorldSprites].x=onevalue[3]
										world.WorldSprites[#world.WorldSprites].y=onevalue[4]
										world.WorldSprites[#world.WorldSprites].rotation=onevalue[5]
										world.WorldSprites[#world.WorldSprites].bodyIndex=#world.WorldSprites
										world.WorldSprites[#world.WorldSprites].typeIndex=index
										world.WorldSprites[#world.WorldSprites].myName="body"
                                                                                world.WorldSprites[#world.WorldSprites].used=false
                                                                                --world.WorldSprites[#world.WorldSprites].alpha=0.7isSensor = true, 
										if(s.radius>0) then
											physics.addBody (world.WorldSprites[#world.WorldSprites], {bounce = s.bounce, density=s.density, friction = s.friction, radius=s.radius, filter=CollisionFilter})
                                                                                else
                                                                                            if s.shape==nil then
                                                                                                physics.addBody (world.WorldSprites[#world.WorldSprites], {bounce = s.bounce, density=s.density, friction = s.friction, filter=CollisionFilter})        
                                                                                            else
                                                                                                physics.addBody (world.WorldSprites[#world.WorldSprites], {shape=s.shape, bounce = s.bounce, density=s.density, friction = s.friction,filter=CollisionFilter})
                                                                                            end
                                                                                            
											
										end --if(s.radius>0) then
		                        	end--if s.type=="trap" then
	                        	end--if index~=-1 then 
	                        end--if onevalue[1]=='body' or onevalue[1]=='trap' then
                        end--if #onevalue>1 then

                end
                
                
                thegame:AddSoundListeners()
                
                --physics.start()
        
  	
        	
end


