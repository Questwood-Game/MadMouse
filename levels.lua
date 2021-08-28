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

ShowAds=false

NumberOfLevels=9

function Bodies(self,levelindex)
    
local Levels={}
Levels[1]="user,40,165,1,150;character,150,266,-1,200,0,0;trap,Trap,564,183,0,1;"
Levels[1]=Levels[1].."body,Book4,93,73,-1;body,Book4,350,89,-271;body,Book3,77,80,-1;body,Book3,67,31,90;body,Book3,109,81,137;body,Book3,422,80,-30;body,Book5,373,29,-90;body,Book2,55,89,-90;body,Book2,85,75,-1;body,Book2,400,75,-1;body,Book1,408,75,-1;body,Book2,432,30,-91;body,Book3,390,80,360;"
Levels[2]="user,130,65,1,150;character,240,146,1,200,0,0;trap,Trap,164,200,0,-1;"
Levels[2]=Levels[2].."body,Bascketball,150,91,-1037;body,Football,87,92,158;body,TennisBall,206,127,151;body,TennisBall,196,127,533;"


Levels[3]="user,435,120,1,150;character,140,200,1,300,0;trap,Trap,-25,230,0,-1;"
Levels[3]=Levels[3].."body,BedStay,181,183,-1;body,TennisBall,496,144,197;body,TennisBall,506,144,74;body,TennisBall,515,144,127;body,Book2,550,71,-2;body,Book2,558,71,-3;body,Book2,573,71,-23;body,Book2,541,71,-2;body,Book4,565,200,90;body,Book3,586,136,-1;body,Book3,579,136,-1;body,Book3,534,146,-90;body,Book4,479,130,-1080;body,BagGreen,492,188,0;"

--335
Levels[4]="user,150,165,1,130;character,370,110,-1,300,0,0;trap,Trap,335,230,0,1;"
Levels[4]=Levels[4].."body,BoxRed,59,79,0;body,BagBlue,55,112,0;body,BoxBlue,47,198,0;body,ShoeGoldRight,42,156,-1;body,ShoeGoldLeft,58,158,-91;body,TennisBall,74,201,20;body,TennisBall,84,201,1686;"

Levels[5]="user,370,188,1,170;character,-32,140,-1,300,0,0;trap,Trap,455,230,0,1;"
Levels[5]=Levels[5].."body,BagBlue,180,162,0;body,Toyball,302,290,0;body,Toyball,362,290,-188;body,BoxYellow,66,296,-1;"
Levels[5]=Levels[5].."body,PillowPink,12,263,89;body,PillowPink,-30,207,-1;body,PiramidToy,230,160,0;"


Levels[6]="user,178,174,1,180;character,460,200,-1,300,250,0;trap,Trap,40,230,0,-1,trap_metal.png;"
Levels[6]=Levels[6].."body,BottleBath3,44,88,0;body,BottleBath6,113,129,-1;body,BottleBath4,75,129,-1;body,BottleBath5,62,92,-1;body,BottleBath9,83,90,0;body,BottleBath10,111,89,359;body,BottleBath8,46,129,-1;body,BottleBath1,129,89,-1;"
Levels[6]=Levels[6].."body,BoxBlue,507,301,-1;"
--body,BottleBath2,490,201,-1;
Levels[7]="user,950,139,1,200;character,1600,150,-1,400,300,0;trap,Trap,650,230,0,-1,trap_metal.png;"
Levels[7]=Levels[7].."body,Cheese,1000,173,0;body,Cheese,1025,173,0;body,Cheese,1010,159,0;body,Cheese,1007,144,0;body,Cheese,853,164,0;body,Cheese,891,166,-1;body,Cheese,1073,166,-721;"
Levels[7]=Levels[7].."body,TennisBall,1630,304,0;"

--mouse would jump on close wall
Levels[8]="user,430,105,1,200;character,60,100,1,450,300,1;trap,Trap,55,230,0,-1,trap_metal.png;"
Levels[8]=Levels[8].."body,Cheese,393,140,0;body,Cheese,420,140,-1;body,Cheese,406,126,0;body,BottleBath8,293,160,0;body,BottleBath8,305,160,0;"
Levels[8]=Levels[8].."body,Cheese,478,140,-1;body,BoxBlue,366,161,-1;body,Book2,218,145,90;body,Book2,218,135,90;"


Levels[9]="user,-50,265,1,200;character,200,50,-1,300,100;trap,Trap,185,230,0,-1;"
Levels[9]=Levels[9].."body,TennisBall,64,294,-60;body,TennisBall,94,294,-93;body,TennisBall,84,294,-93;"
Levels[9]=Levels[9].."body,Cheese,-0,0,0"

Levels[10]="user,150,165,1,200;character,370,100,-1;trap,Trap,335,230,0,1;"
Levels[10]=Levels[10].."body,Bascketball,64,294,-60;body,Bascketball,94,294,-93;"

Levels[11]="user,150,165,1,200;character,370,100,-1;trap,Trap,335,230,0,1;"
Levels[11]=Levels[11].."body,Bascketball,64,294,-60;body,Bascketball,94,294,-93;"

Levels[12]="user,150,165,1,200;character,370,100,-1;trap,Trap,335,230,0,-1;"
Levels[12]=Levels[12].."body,Bascketball,64,294,-60;body,Bascketball,94,294,-93;"
return Levels[levelindex];
end


local function CreateLevel_1() -- iPad compatible
    ShowAds=true
    world.ScreenMinX=-450
    world.ScreenMaxX=450
    local x= display.contentWidth*0.5

    world.BGSprites[1]={image="src/images/levels/level_1_bg0.png"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x =x; world.BGSprites[1].y = display.contentHeight-33
			world.BGSprites[1].width=1360;world.BGSprites[1].height=456
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        
                        --buttom
        		world.WorldWalls[1] = display.newRect(0 ,0,1476,16)
        		world.WorldWalls[1]:setFillColor(0,0,255,0)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =display.contentWidth*0.5 ;  world.WorldWalls[1].y = display.contentHeight-30
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0
                                                
                       --right invisible roof
			world.WorldWalls[2] = display.newRect(0 ,0,1476,16)
			world.WorldWalls[2]:setFillColor(50, 100,255, 0)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =305 ;  world.WorldWalls[2].y = display.contentHeight-450
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=34
			--left invisible roof
			world.WorldWalls[3] = display.newRect(0 ,0,1476,16)
			world.WorldWalls[3]:setFillColor(50, 100,255, 0)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =180 ;  world.WorldWalls[3].y = display.contentHeight-450
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=-34
			--shelfs
			world.WorldWalls[4] = display.newRect(0 ,0,130,8)
			world.WorldWalls[4]:setFillColor(50, 100,255, 0)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =90 ;  world.WorldWalls[4].y = display.contentHeight-218
                        world.WorldWalls[4].myName="CloseWall"
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
			
			world.WorldWalls[5] = display.newRect(0 ,0,130,8)
			world.WorldWalls[5]:setFillColor(50, 100,255, 0)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =405 ;  world.WorldWalls[5].y = display.contentHeight-218
                        world.WorldWalls[5].myName="CloseWall"
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
			
			world.WorldWalls[6] = display.newRect(0 ,0,130,7)
			world.WorldWalls[6]:setFillColor(50, 100,255, 0)
			world.WorldWalls[6]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[6].x =90 ;  world.WorldWalls[6].y = display.contentHeight-278
                        world.WorldWalls[6].myName="CloseWall"
			world.WorldWalls[6].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[6].rotation=0

			world.WorldWalls[7] = display.newRect(0 ,0,130,7)
			world.WorldWalls[7]:setFillColor(50, 100,255, 0)
			world.WorldWalls[7]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[7].x =405 ;  world.WorldWalls[7].y = display.contentHeight-278
                        world.WorldWalls[7].myName="CloseWall"
			world.WorldWalls[7].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[7].rotation=0
                        
                        

                        
                        --right hor roof - brown very small
                        world.WorldWalls[8] = display.newRect(0 ,0,100,84)
        		world.WorldWalls[8]:setFillColor(120, 95,66, 255)
			world.WorldWalls[8]:setReferencePoint( display.BottomLeftReferencePoint )
			world.WorldWalls[8].x =920 ;  world.WorldWalls[8].y = display.contentHeight
			world.WorldWalls[8].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[8].rotation=0
                        
                        -- angle
                        world.WorldWalls[9] = display.newRect(0 ,0,1690,80)
			world.WorldWalls[9]:setFillColor(205, 127,75, 255)
			world.WorldWalls[9]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[9].x =366 ;  world.WorldWalls[9].y = display.contentHeight-445
			world.WorldWalls[9].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[9].rotation=34
                        --light brown  roof
                        world.WorldWalls[10] = display.newRect(0 ,0,1000,84)
        		world.WorldWalls[10]:setFillColor(205, 127,75, 255)
			world.WorldWalls[10]:setReferencePoint( display.BottomLeftReferencePoint )
			world.WorldWalls[10].x =1005 ;  world.WorldWalls[10].y = display.contentHeight-27
			world.WorldWalls[10].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[10].rotation=0
                        
                        
                         --left hor roof - brown very small
                        world.WorldWalls[11] = display.newRect(0 ,0,100,84)
        		world.WorldWalls[11]:setFillColor(120, 95,66, 255)
			world.WorldWalls[11]:setReferencePoint( display.BottomLeftReferencePoint )
			world.WorldWalls[11].x =-540 ;  world.WorldWalls[11].y = display.contentHeight
			world.WorldWalls[11].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[11].rotation=0
                        
                        -- left angle
                        world.WorldWalls[12] = display.newRect(0 ,0,1690,85)
			world.WorldWalls[12]:setFillColor(205, 127,75, 255)
			world.WorldWalls[12]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[12].x =106 ;  world.WorldWalls[12].y = display.contentHeight-445
			world.WorldWalls[12].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[12].rotation=-34
                        
                        
                        --left light brown  roof 
                        world.WorldWalls[13] = display.newRect(0 ,0,1000,84)
        		world.WorldWalls[13]:setFillColor(205, 127,75, 255)
			world.WorldWalls[13]:setReferencePoint( display.BottomRightReferencePoint )
			world.WorldWalls[13].x =-500 ;  world.WorldWalls[13].y = display.contentHeight-27
			world.WorldWalls[13].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[13].rotation=0
                        
                        
                        
                        
                        
                        -- dark brown  floor and roof
                        world.WorldWalls[14] = display.newRect(0 ,0,3076,34)
        		world.WorldWalls[14]:setFillColor(120, 95,66, 255)
			world.WorldWalls[14]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[14].x =display.contentWidth*0.5 ;  world.WorldWalls[14].y = display.contentHeight
			world.WorldWalls[14].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[14].rotation=0
                        
                        
                        --bottom wall 
                        world.WorldWalls[15] = display.newRect(0 ,0,3000,200)
                        world.WorldWalls[15]:setFillColor(127, 106,79, 255)
                        --world.WorldWalls[15]:setFillColor(0, 0,255, 255)
                        world.WorldWalls[15]:setReferencePoint( display.TopCenterReferencePoint )
                        world.WorldWalls[15].x =-500
                        world.WorldWalls[15].y = display.contentHeight-10
                        world.WorldWalls[15].physics={ friction=0.5, bounce=0.3 } 
end

local function CreateLevel_2() -- iPad compatible
    ShowAds=false
                         world.ScreenMinX=-450
			world.ScreenMaxX=450
                        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_2_bg0.png"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x = display.contentWidth*0.5; world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=341;world.BGSprites[1].height=392
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        world.BGSprites[2]={image="src/images/levels/level_2_bg1.png"}
                        world.BGSprites[2].xScale = 1; world.BGSprites[2].yScale = 1
			world.BGSprites[2].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[2].x = display.contentWidth*0.5; world.BGSprites[2].y = display.contentHeight
			world.BGSprites[2].width=341;world.BGSprites[2].height=392
			world.BGSprites[2].dx = 1.03
			world.BGSprites[2].layer=1
                        
                        
                        --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,372,50)
			world.WorldWalls[1]:setFillColor(127, 106,79, 255)
                        --world.WorldWalls[1]:setFillColor(0, 0,255, 255)
                        
			world.WorldWalls[1]:setReferencePoint( display.TopCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0
                        
                        
                        --- Big walls
                        -- right wall
                        world.WorldWalls[2] = display.newRect(0 ,0,500,592)
			world.WorldWalls[2]:setFillColor(78, 69,57, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomLeftReferencePoint )
			world.WorldWalls[2].x =x+183
                        world.WorldWalls[2].y = display.contentHeight+50
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,592)
			world.WorldWalls[3]:setFillColor(78, 69,57, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomRightReferencePoint )
			world.WorldWalls[3].x =x-183
                        world.WorldWalls[3].y = display.contentHeight+50
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                        
                        
                        -- normall walls
                        -- right wall
                        world.WorldWalls[4] = display.newRect(0 ,0,16,392)
			world.WorldWalls[4]:setFillColor(127, 106,79, 255)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x+175
                        world.WorldWalls[4].y = display.contentHeight
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        -- left wall
                        world.WorldWalls[5] = display.newRect(0 ,0,16,392)
			world.WorldWalls[5]:setFillColor(127, 106,79, 255)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x-175
                        world.WorldWalls[5].y = display.contentHeight
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                        --stairs
                        local stepX=x-66
                        local stepY=display.contentHeight-202
                        
                        for i=1,5 do
                                world.WorldWalls[5+i] = display.newRect(0 ,0,32,22)
                                world.WorldWalls[5+i]:setFillColor(164, 46,23, 255)
                                world.WorldWalls[5+i]:setReferencePoint( display.CenterCenterReferencePoint )
                                world.WorldWalls[5+i].x = stepX+(i-1)*31
                                world.WorldWalls[5+i].y = stepY+(i-1)*26
                                --[[
                                if i<3 then
                                    world.WorldWalls[5+i]:setFillColor(164, 46,255, 200)
                                    world.WorldWalls[5+i].myName="CloseWall"
                                else
                                    world.WorldWalls[5+i]:setFillColor(164, 46,23, 255)
                                end
                                ]]--
                		world.WorldWalls[5+i].physics={ friction=0.5, bounce=0.3 } 
        			world.WorldWalls[5+i].rotation=0
                        end
                        
                        world.WorldWalls[11] = display.newRect(0 ,0,33,3)
                        world.WorldWalls[11]:setFillColor(164, 46,23, 255)
                        world.WorldWalls[11]:setReferencePoint( display.CenterCenterReferencePoint )
                        world.WorldWalls[11].x = stepX+(5)*31
                        world.WorldWalls[11].y = stepY+(5)*26-14
                	world.WorldWalls[11].physics={ friction=0.5, bounce=0.3 } 
        		world.WorldWalls[11].rotation=0
                       
                        
                        local stepX=x-88
                        local stepY=display.contentHeight-262
                        --[[
                        for i=1,3 do
                                world.WorldWalls[11+i] = display.newRect(0 ,0,31,5)
                                world.WorldWalls[11+i]:setFillColor(139,50,18, 200)
                                world.WorldWalls[11+i]:setReferencePoint( display.CenterCenterReferencePoint )
                                world.WorldWalls[11+i].x = stepX+(i-1)*31
                                world.WorldWalls[11+i].y = stepY-(i-1)*26
                		world.WorldWalls[11+i].physics={ friction=0.5, bounce=0.3 } 
        			world.WorldWalls[11+i].rotation=0
                        end
                        ]]--
                        -- last stair
                        world.WorldWalls[12] = display.newRect(0 ,0,100,10)
                        world.WorldWalls[12]:setFillColor(164, 46,23, 255)
                        world.WorldWalls[12]:setReferencePoint( display.CenterCenterReferencePoint )
                        world.WorldWalls[12].x = x-117
                        
                        world.WorldWalls[12].y = stepY+54
                        --world.WorldWalls[12].myName="CloseWall"
                	world.WorldWalls[12].physics={ friction=0.5, bounce=0.3 } 
        		world.WorldWalls[12].rotation=0

        
                        --top
                        world.WorldWalls[13] = display.newRect(0 ,0,341,70)
			world.WorldWalls[13]:setFillColor(127, 106,79, 255)
                        
			world.WorldWalls[13]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[13].x =x ;  world.WorldWalls[13].y = display.contentHeight-350
			world.WorldWalls[13].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[13].rotation=0
                        
                        
                        
                   
        
           
end

local function CreateLevel_3() -- iPad compatible
    ShowAds=false
        world.ScreenMinX=-450
			world.ScreenMaxX=450
                        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_3_bg0.png"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x = display.contentWidth*0.5; world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=730;world.BGSprites[1].height=404
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,1000,70)
			world.WorldWalls[1]:setFillColor(127, 106,79, 255)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight+65
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0

                        
                        --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =x+615
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-615
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                        --Bed Floor
                        world.WorldWalls[4] = display.newRect(0 ,0,225,5)
			world.WorldWalls[4]:setFillColor(255, 0,0,0)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x -167;
                        world.WorldWalls[4].y = display.contentHeight-98
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        
                        --Bed Wall
                        world.WorldWalls[5] = display.newRect(0 ,0,10,73)
			world.WorldWalls[5]:setFillColor(255, 0,0,0)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x -277;
                        world.WorldWalls[5].y = display.contentHeight-102
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                        --Shelfs
                        world.WorldWalls[6] = display.newRect(0 ,0,132,5)
			world.WorldWalls[6]:setFillColor(90,31, 11, 255)
			world.WorldWalls[6]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[6].x =x+291;
                        world.WorldWalls[6].y = display.contentHeight-278
			world.WorldWalls[6].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[6].rotation=0
                        
                        world.WorldWalls[7] = display.newRect(0 ,0,132,5)
			world.WorldWalls[7]:setFillColor(90,31, 11, 255)
			world.WorldWalls[7]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[7].x =x+291;
                        world.WorldWalls[7].y = display.contentHeight-225
			world.WorldWalls[7].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[7].rotation=0
                        
                        world.WorldWalls[8] = display.newRect(0 ,0,132,5)
			world.WorldWalls[8]:setFillColor(90,31, 11, 255)
			world.WorldWalls[8]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[8].x =x+291;
                        world.WorldWalls[8].y = display.contentHeight-165
			world.WorldWalls[8].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[8].rotation=0
                        
                        world.WorldWalls[9] = display.newRect(0 ,0,132,5)
			world.WorldWalls[9]:setFillColor(90,31, 11, 255)
			world.WorldWalls[9]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[9].x =x+291;
                        world.WorldWalls[9].y = display.contentHeight-110
			world.WorldWalls[9].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[9].rotation=0
                        
                        world.WorldWalls[10] = display.newRect(0 ,0,8,170)
			world.WorldWalls[10]:setFillColor(0, 255,0,0)
			world.WorldWalls[10]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[10].x =x+229;
                        world.WorldWalls[10].y = display.contentHeight-110
			world.WorldWalls[10].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[10].rotation=0
                        
                        --bottom
                        world.WorldWalls[11] = display.newRect(0 ,0,1000,70)
			--world.WorldWalls[11]:setFillColor(0, 0,255,255)
                        world.WorldWalls[11]:setFillColor(0, 255,0, 155)
			world.WorldWalls[11]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[11].x =x ;  world.WorldWalls[11].y = display.contentHeight-350
			world.WorldWalls[11].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[11].rotation=0
         
         
         
         

end

local function CreateLevel_4() -- iPad compatible
    ShowAds=false
        world.ScreenMinX=-450
	world.ScreenMaxX=450
        local x=display.contentWidth*0.5
                        
	world.BGSprites[1]={image="src/images/levels/level_4_bg0.png"}
	world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
	world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
	world.BGSprites[1].x = display.contentWidth*0.5; world.BGSprites[1].y = display.contentHeight-7
	world.BGSprites[1].width=432;world.BGSprites[1].height=396--411
	world.BGSprites[1].dx = 1
	world.BGSprites[1].layer=0
                        
        --bottom
        world.WorldWalls[1] = display.newRect(0 ,0,1000,70)
			world.WorldWalls[1]:setFillColor(127, 106,79, 0)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight+55
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0

                        
                        --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =x+463
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-465
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                                              
                        --top
                        world.WorldWalls[4] = display.newRect(0 ,0,1000,70)
                        world.WorldWalls[4]:setFillColor(0, 255,0, 155)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x ;  world.WorldWalls[4].y = display.contentHeight-350
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        
                        
                        --mouse stage
                        world.WorldWalls[5] = display.newRect(0 ,0,55,20)
			world.WorldWalls[5]:setFillColor(0, 255,0,0)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x+120;
                        world.WorldWalls[5].y = display.contentHeight-135
                        world.WorldWalls[5].myName="CloseWall"
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                        
                        --mouse stage wall
                        world.WorldWalls[6] = display.newRect(0 ,0,5,60)
			world.WorldWalls[6]:setFillColor(0, 255,0,0)
			world.WorldWalls[6]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[6].x =x+149;
                        world.WorldWalls[6].y = display.contentHeight-95
                        world.WorldWalls[6].myName="CloseWall"
			world.WorldWalls[6].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[6].rotation=0

                        
                        --shelfs
                        --world.WorldWalls[7] = display.newRect(0 ,0,176,5)
			--world.WorldWalls[7]:setFillColor(0, 255,0,255)
			--world.WorldWalls[7]:setReferencePoint( display.BottomCenterReferencePoint )
			--world.WorldWalls[7].x =x-118;
                        --world.WorldWalls[7].y = display.contentHeight-108
			--world.WorldWalls[7].physics={ friction=0.5, bounce=0.3 } 
			--world.WorldWalls[7].rotation=0
                        
                        --world.WorldWalls[7] = display.newRect(0 ,0,176,5)
			--world.WorldWalls[7]:setFillColor(90,31, 11, 255)
			--world.WorldWalls[7]:setReferencePoint( display.BottomCenterReferencePoint )
			--world.WorldWalls[7].x =x-118;
                        --world.WorldWalls[7].y = display.contentHeight-262
			--world.WorldWalls[7].physics={ friction=0.5, bounce=0.3 } 
			--world.WorldWalls[7].rotation=0
                        --small shelfs
                        
                        world.WorldWalls[7] = display.newRect(0 ,0,55,5)
			world.WorldWalls[7]:setFillColor(90,31, 11, 0)
			world.WorldWalls[7]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[7].x =x-178;
                        world.WorldWalls[7].y = display.contentHeight-108
                        world.WorldWalls[7].myName="CloseWall"
			world.WorldWalls[7].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[7].rotation=0
                        
                        world.WorldWalls[8] = display.newRect(0 ,0,55,5)
			world.WorldWalls[8]:setFillColor(90,31, 11, 0)
			world.WorldWalls[8]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[8].x =x-178;
                        world.WorldWalls[8].y = display.contentHeight-149
                        world.WorldWalls[8].myName="CloseWall"
			world.WorldWalls[8].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[8].rotation=0
                        
                        world.WorldWalls[9] = display.newRect(0 ,0,55,5)
			world.WorldWalls[9]:setFillColor(90,31, 11, 0)
			world.WorldWalls[9]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[9].x =x-178;
                        world.WorldWalls[9].y = display.contentHeight-188
                        world.WorldWalls[9].myName="CloseWall"
			world.WorldWalls[9].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[9].rotation=0
                        
                        world.WorldWalls[10] = display.newRect(0 ,0,55,5)
			world.WorldWalls[10]:setFillColor(90,31, 11, 0)
			world.WorldWalls[10]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[10].x =x-178;
                        world.WorldWalls[10].y = display.contentHeight-227
                        world.WorldWalls[10].myName="CloseWall"
			world.WorldWalls[10].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[10].rotation=0
                        
                        
                                                
                        --mouse stage small left wall
                        --world.WorldWalls[11] = display.newRect(0 ,0,30,5)
			--world.WorldWalls[11]:setFillColor(0, 255,0,0)
			--world.WorldWalls[11]:setReferencePoint( display.BottomCenterReferencePoint )
			--world.WorldWalls[11].x =x+85;
                        --world.WorldWalls[11].y = display.contentHeight-113
			--world.WorldWalls[11].physics={ friction=0.5, bounce=0.3 } 
			--world.WorldWalls[11].rotation=0
                        
                        --bottom brown
                        world.WorldWalls[12] = display.newRect(0 ,0,1000,76)
			world.WorldWalls[12]:setFillColor(127, 106,79, 255)
			world.WorldWalls[12]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[12].x =x ;  world.WorldWalls[12].y = display.contentHeight+65
			world.WorldWalls[12].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[12].rotation=0
                        
end

local function CreateLevel_5() -- iPad compatible
    ShowAds=false
        world.ScreenMinX=-450
			world.ScreenMaxX=450
                        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_5_bg0.png"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x = display.contentWidth*0.5; world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=606;world.BGSprites[1].height=412
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        world.BGSprites[2]={image="src/images/levels/level_5_1bg1.png"}
			world.BGSprites[2].xScale = 1; world.BGSprites[2].yScale = 1
			world.BGSprites[2].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[2].x = x-227; world.BGSprites[2].y = display.contentHeight-12
			world.BGSprites[2].width=104;world.BGSprites[2].height=70
			world.BGSprites[2].dx = 1
			world.BGSprites[2].layer=1
                        
                        
                        world.BGSprites[3]={image="src/images/levels/level_5_2bg1.png"}
			world.BGSprites[3].xScale = 1; world.BGSprites[3].yScale = 1
			world.BGSprites[3].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[3].x = x+142; world.BGSprites[3].y = display.contentHeight-87
			world.BGSprites[3].width=78;world.BGSprites[3].height=56
			world.BGSprites[3].dx = 1
			world.BGSprites[3].layer=1                        
                         --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
			world.WorldWalls[1]:setFillColor(127, 106,79, 0)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight+57
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0
   --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =x+world.BGSprites[1].width*0.5+242
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-world.BGSprites[1].width*0.5-242
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                                              
                        --top
                        world.WorldWalls[4] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
                        world.WorldWalls[4]:setFillColor(0, 255, 0, 0)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x ;  world.WorldWalls[4].y = display.contentHeight-350
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        
                        
                        --table
                        world.WorldWalls[5] = display.newRect(0 ,0,135,5)
			world.WorldWalls[5]:setFillColor(0, 255, 0, 0)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x-13;
                        world.WorldWalls[5].y = display.contentHeight-138
                        world.WorldWalls[5].myName="CloseWall"
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                        
                        --sofa floor
                        world.WorldWalls[6] = display.newRect(0 ,0,20,3)
			world.WorldWalls[6]:setFillColor(0, 255, 0, 0)
			world.WorldWalls[6]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[6].x =x-250;
                        world.WorldWalls[6].y = display.contentHeight-35
                        world.WorldWalls[6].myName="CloseWall"
			world.WorldWalls[6].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[6].rotation=0
                        
                        world.WorldWalls[7] = display.newRect(0 ,0,20,3)
			world.WorldWalls[7]:setFillColor(0, 255, 0, 0)
			world.WorldWalls[7]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[7].x =x-210;
                        world.WorldWalls[7].myName="CloseWall"
                        world.WorldWalls[7].y = display.contentHeight-39
			world.WorldWalls[7].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[7].rotation=0
 
                        
                        --bottom wall 
                        world.WorldWalls[12] = display.newRect(0 ,0,3000,100)
                        world.WorldWalls[12]:setFillColor(127, 106,79, 255)
                        world.WorldWalls[12]:setReferencePoint( display.TopCenterReferencePoint )
                        world.WorldWalls[12].x =-500
                        world.WorldWalls[12].y = display.contentHeight
        
                        
end

local function CreateLevel_6() -- iPad compatible
    ShowAds=false
          world.ScreenMinX=-450
			world.ScreenMaxX=450
                        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_6_bg0.png"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x = display.contentWidth*0.5; world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=578;world.BGSprites[1].height=412
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,1000,70)
			world.WorldWalls[1]:setFillColor(127, 106,79, 255)--(127, 106,79, 200)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight+60
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0
   --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(127, 106,79, 255)--setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =x+world.BGSprites[1].width*0.5+242
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(127, 106,79, 255)--setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-world.BGSprites[1].width*0.5-242
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                                              
                        --top
                        world.WorldWalls[4] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
                        world.WorldWalls[4]:setFillColor(0, 0, 255, 200)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x ;  world.WorldWalls[4].y = display.contentHeight-350
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        
                        
                        --mouse stage
                        world.WorldWalls[5] = display.newRect(0 ,0,70,5)
			world.WorldWalls[5]:setFillColor(0, 0, 255, 0)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x+220;
                        world.WorldWalls[5].y = display.contentHeight-95
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                    
                    
                         -- shelfs
                        world.WorldWalls[6] = display.newRect(0 ,0,115,3)
			world.WorldWalls[6]:setFillColor(0, 0, 255, 0)
			world.WorldWalls[6]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[6].x =x-153;
                        world.WorldWalls[6].y = display.contentHeight-210
                        world.WorldWalls[6].myName="CloseWall"
			world.WorldWalls[6].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[6].rotation=0
                        
                                                 -- shelfs
                        world.WorldWalls[7] = display.newRect(0 ,0,115,3)
			world.WorldWalls[7]:setFillColor(0, 0, 255, 0)
			world.WorldWalls[7]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[7].x =x-153;
                        world.WorldWalls[7].y = display.contentHeight-173
                        world.WorldWalls[7].myName="CloseWall"
			world.WorldWalls[7].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[7].rotation=0
                        
                        --mouse stage
                        world.WorldWalls[8] = display.newRect(0 ,0,5,40)
			world.WorldWalls[8]:setFillColor(0, 0, 255, 0)
			world.WorldWalls[8]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[8].x =x+260;
                        world.WorldWalls[8].y = display.contentHeight-95
			world.WorldWalls[8].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[8].rotation=0
                           
end

local function CreateLevel_7() -- iPad compatible
    ShowAds=false
          world.ScreenMinX=-5000
			world.ScreenMaxX=5000
                        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_7_bg0.png"}
			
			world.BGSprites[1].ReferencePoint= display.BottomLeftReferencePoint 
			world.BGSprites[1].x =x-- 0--display.contentWidth*0.5;
                        world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=1396;
                        world.BGSprites[1].height=390
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0

                        
                        --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
			world.WorldWalls[1]:setFillColor(127, 106,79, 200)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x+world.BGSprites[1].width*0.5 ;  world.WorldWalls[1].y = display.contentHeight+60
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0

                        
                        --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =world.BGSprites[1].x+world.BGSprites[1].width+250  --x+(461+170+414)-250
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-247
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                        --table
                        world.WorldWalls[4] = display.newRect(0 ,0,260,10)
			world.WorldWalls[4]:setFillColor(0, 255, 0, 0)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x+720;
                        world.WorldWalls[4].y = display.contentHeight-129
                        world.WorldWalls[4].myName="CloseWall"
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                    
                        --bottom transparent
                        world.WorldWalls[5] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
			world.WorldWalls[5]:setFillColor(0, 0,255, 0)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x+world.BGSprites[1].width*0.5 ;  world.WorldWalls[5].y = display.contentHeight+53
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                        
                        

                        --bottom
                        world.WorldWalls[6] = display.newRect(0 ,0,3000,100)
			--world.WorldWalls[6]:setFillColor(0, 0,255,255)
                        world.WorldWalls[6]:setFillColor(127, 106,79, 255)
			world.WorldWalls[6]:setReferencePoint( display.TopCenterReferencePoint )
			world.WorldWalls[6].x =x ;  world.WorldWalls[6].y = display.contentHeight
			world.WorldWalls[6].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[6].rotation=0

end

local function CreateLevel_8() -- iPad compatible
       ShowAds=false
        world.ScreenMinX=-450
	world.ScreenMaxX=450
        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_8_bg0.png"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x = x; world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=518;world.BGSprites[1].height=396
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
			world.WorldWalls[1]:setFillColor(127, 106,79, 200)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight+60
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0

                        
                        --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =x+world.BGSprites[1].width*0.5+250
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-world.BGSprites[1].width*0.5-250
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                                              
                        --top
                        world.WorldWalls[4] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
                        world.WorldWalls[4]:setFillColor(0, 255, 0, 200)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x ;  world.WorldWalls[4].y = display.contentHeight-350
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        
                        
                        --mouse stage 1
                        world.WorldWalls[5] = display.newRect(0 ,0,215,8)
			world.WorldWalls[5]:setFillColor(255, 0, 0, 0)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x-121;
                        world.WorldWalls[5].y = display.contentHeight-162
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                        
                        --mouse stage 2
                        world.WorldWalls[6] = display.newRect(0 ,0,92,10)
			world.WorldWalls[6]:setFillColor(0, 255, 0, 0)
			world.WorldWalls[6]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[6].x =x+87;
                        world.WorldWalls[6].y = display.contentHeight-134
                        world.WorldWalls[6].myName="CloseWall"
			world.WorldWalls[6].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[6].rotation=0
                        
                        --user stage 1 -washing machine
                        world.WorldWalls[7] = display.newRect(0 ,0,110,50)
			world.WorldWalls[7]:setFillColor(0, 0, 255, 0)
			world.WorldWalls[7]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[7].x =x+194;
                        world.WorldWalls[7].y = display.contentHeight-122
                        world.WorldWalls[7].myName="CloseWall"
                        world.WorldWalls[7].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[7].rotation=0
                        
                         --bottom invisible
                        world.WorldWalls[8] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
			world.WorldWalls[8]:setFillColor(255, 0, 0, 0)--(127, 106,79, 200)
			world.WorldWalls[8]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[8].x =x ;  world.WorldWalls[8].y = display.contentHeight+55
			world.WorldWalls[8].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[8].rotation=0
                        
                       --Iron
                        world.WorldWalls[9] = display.newRect(0 ,0,25,40)
			world.WorldWalls[9]:setFillColor(255, 0, 0, 0)
			world.WorldWalls[9]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[9].x =x-205;
                        world.WorldWalls[9].y = display.contentHeight-167
			world.WorldWalls[9].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[9].rotation=0
                    
                            
                            
                       --bottom
                        world.WorldWalls[10] = display.newRect(0 ,0,1000,100)
			--world.WorldWalls[10]:setFillColor(0, 0,255,255)
                        world.WorldWalls[10]:setFillColor(127, 106,79, 255)
			world.WorldWalls[10]:setReferencePoint( display.TopCenterReferencePoint )
			world.WorldWalls[10].x =x ;  world.WorldWalls[10].y = display.contentHeight
			world.WorldWalls[10].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[10].rotation=0
end

local function CreateLevel_9() -- iPad compatible
    ShowAds=false
         world.ScreenMinX=-450
			world.ScreenMaxX=450
                        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_9_bg0.png"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x = x; world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=686;world.BGSprites[1].height=410
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
			world.WorldWalls[1]:setFillColor(127, 106,79, 255)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight+60
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0

                        
                        --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =x+world.BGSprites[1].width*0.5+242
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-world.BGSprites[1].width*0.5-242
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                                              
                        --top
                        world.WorldWalls[4] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
                        world.WorldWalls[4]:setFillColor(0, 255, 0, 255)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x ;  world.WorldWalls[4].y = display.contentHeight-350
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        
                        
                        --mouse stage
                        world.WorldWalls[5] = display.newRect(0 ,0,290,20)
			world.WorldWalls[5]:setFillColor(0, 255, 0, 0)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x-90;
                        world.WorldWalls[5].y = display.contentHeight-207
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                        world.WorldWalls[5].myName="CloseWall"
                       
                        world.WorldWalls[6] = display.newRect(0 ,0,100,20)
			world.WorldWalls[6]:setFillColor(0, 255, 0, 0)
			world.WorldWalls[6]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[6].x =x+83;
                        world.WorldWalls[6].y = display.contentHeight-173
			world.WorldWalls[6].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[6].rotation=40
                        world.WorldWalls[6].myName="CloseWall"
                        --[[ --]]
                        world.WorldWalls[7] = display.newRect(0 ,0,50,100)
			world.WorldWalls[7]:setFillColor(0, 255, 0, 0)
                        world.WorldWalls[7].rotation=20
                        world.WorldWalls[7].myName="CloseWall"
			world.WorldWalls[7]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[7].x =x-240;
                        world.WorldWalls[7].y = display.contentHeight-110
                        
			world.WorldWalls[7].physics={ friction=0.5, bounce=0.3 } 
			
                       
                        
                        world.WorldWalls[8] = display.newRect(0 ,0,140,20)
			world.WorldWalls[8]:setFillColor(0, 255, 0, 0)
			world.WorldWalls[8]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[8].x =x+180;
                        world.WorldWalls[8].y = display.contentHeight-145
			world.WorldWalls[8].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[8].rotation=4
                        world.WorldWalls[8].myName="CloseWall"
                       
                       
                        --bottom
                        world.WorldWalls[9] = display.newRect(0 ,0,1000,100)
			--world.WorldWalls[9]:setFillColor(0, 0,255,255)
                        world.WorldWalls[9]:setFillColor(127, 106,79, 255)
			world.WorldWalls[9]:setReferencePoint( display.TopCenterReferencePoint )
			world.WorldWalls[9].x =x ;  world.WorldWalls[9].y = display.contentHeight
			world.WorldWalls[9].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[9].rotation=0
end

local function CreateLevel_10()
    ShowAds=false
        world.ScreenMinX=-450
			world.ScreenMaxX=450
                        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_10_bg0.jpg"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x = x; world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=386;world.BGSprites[1].height=376
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
			world.WorldWalls[1]:setFillColor(0, 255, 0, 200)--(127, 106,79, 200)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight+60
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0

                        
                        --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(0, 255, 0, 200)--setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =x+world.BGSprites[1].width*0.5+236
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(0, 255, 0, 200)--setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-world.BGSprites[1].width*0.5-236
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                                              
                        --top
                        world.WorldWalls[4] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
                        world.WorldWalls[4]:setFillColor(0, 255, 0, 200)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x ;  world.WorldWalls[4].y = display.contentHeight-350
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        
                        
                        --mouse stage
                        world.WorldWalls[5] = display.newRect(0 ,0,155,20)
			world.WorldWalls[5]:setFillColor(0, 255, 0, 200)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x+100;
                        world.WorldWalls[5].y = display.contentHeight-135
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                           
end

local function CreateLevel_11()
    ShowAds=false
          world.ScreenMinX=-450
			world.ScreenMaxX=450
                        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_11_bg0.jpg"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x = x; world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=395;world.BGSprites[1].height=376
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
			world.WorldWalls[1]:setFillColor(0, 255, 0, 200)--(127, 106,79, 200)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight+60
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0

                        
                        --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(0, 255, 0, 200)--setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =x+world.BGSprites[1].width*0.5+242
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(0, 255, 0, 200)--setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-world.BGSprites[1].width*0.5-242
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                                              
                        --top
                        world.WorldWalls[4] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
                        world.WorldWalls[4]:setFillColor(0, 255, 0, 200)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x ;  world.WorldWalls[4].y = display.contentHeight-350
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        
                        
                        --mouse stage
                        world.WorldWalls[5] = display.newRect(0 ,0,155,20)
			world.WorldWalls[5]:setFillColor(0, 255, 0, 200)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x+120;
                        world.WorldWalls[5].y = display.contentHeight-135
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                    
                           
end

local function CreateLevel_12()
    ShowAds=false
           world.ScreenMinX=-450
			world.ScreenMaxX=450
                        local x=display.contentWidth*0.5
                        
			world.BGSprites[1]={image="src/images/levels/level_12_bg0.jpg"}
			world.BGSprites[1].xScale = 1; world.BGSprites[1].yScale = 1
			world.BGSprites[1].ReferencePoint= display.BottomCenterReferencePoint 
			world.BGSprites[1].x = x; world.BGSprites[1].y = display.contentHeight
			world.BGSprites[1].width=392;world.BGSprites[1].height=376
			world.BGSprites[1].dx = 1
			world.BGSprites[1].layer=0
                        
                        --bottom
                        world.WorldWalls[1] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
			world.WorldWalls[1]:setFillColor(0, 255, 0, 200)--(127, 106,79, 200)
			world.WorldWalls[1]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[1].x =x ;  world.WorldWalls[1].y = display.contentHeight+60
			world.WorldWalls[1].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[1].rotation=0

                        
                        --right wall 
                        world.WorldWalls[2] = display.newRect(0 ,0,500,392)
			world.WorldWalls[2]:setFillColor(0, 255, 0, 200)--setFillColor(127, 106,79, 255)
			world.WorldWalls[2]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[2].x =x+world.BGSprites[1].width*0.5+242
                        world.WorldWalls[2].y = display.contentHeight
			world.WorldWalls[2].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[2].rotation=0
                        --left wall
                        world.WorldWalls[3] = display.newRect(0 ,0,500,392)
			world.WorldWalls[3]:setFillColor(0, 255, 0, 200)--setFillColor(127, 106,79, 255)
			world.WorldWalls[3]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[3].x =x-world.BGSprites[1].width*0.5-242
                        world.WorldWalls[3].y = display.contentHeight
			world.WorldWalls[3].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[3].rotation=0
                        
                                              
                        --top
                        world.WorldWalls[4] = display.newRect(0 ,0,world.BGSprites[1].width+100,70)
                        world.WorldWalls[4]:setFillColor(0, 255, 0, 200)
			world.WorldWalls[4]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[4].x =x ;  world.WorldWalls[4].y = display.contentHeight-350
			world.WorldWalls[4].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[4].rotation=0
                        
                        
                        --mouse stage
                        world.WorldWalls[5] = display.newRect(0 ,0,55,20)
			world.WorldWalls[5]:setFillColor(0, 255, 0, 200)
			world.WorldWalls[5]:setReferencePoint( display.BottomCenterReferencePoint )
			world.WorldWalls[5].x =x+120;
                        world.WorldWalls[5].y = display.contentHeight-135
			world.WorldWalls[5].physics={ friction=0.5, bounce=0.3 } 
			world.WorldWalls[5].rotation=0
                    
                          
end



function CreateLevel(self, levelIndex)
        
	world.BGSprites={}
        world.WorldWalls={}

	if levelIndex==1 then
            CreateLevel_1()
        elseif levelIndex==2 then
            CreateLevel_2()                
        elseif levelIndex==3 then
            CreateLevel_3()                            
        elseif levelIndex==4 then
            CreateLevel_4()
        elseif levelIndex==5 then
            CreateLevel_5()
        elseif levelIndex==6 then
            CreateLevel_6()
        elseif levelIndex==7 then
            CreateLevel_7()
        elseif levelIndex==8 then
            CreateLevel_8()
        elseif levelIndex==9 then
            CreateLevel_9()
        elseif levelIndex==10 then
            CreateLevel_10()
        elseif levelIndex==11 then
            CreateLevel_11()
        elseif levelIndex==12 then
            CreateLevel_12()
        end
    
end

