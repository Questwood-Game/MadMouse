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

SpriteColection={}

function AddSprites(self)

	
	-- First Try Objects
--[[
--	SpriteColection[#SpriteColection + 1] = {type="body", title="Brick", image="brick_100.png", density=10.0, friction=1, bounce=0.2, radius=-1,x=0 }
--	SpriteColection[#SpriteColection + 1] = {type="body",  title="Small Brick", image="brick_50.png", density=10.0, friction=1, bounce=0.2, radius=-1,x=0 }
--	SpriteColection[#SpriteColection + 1] = {type="body",  title="Light Brick", image="brick_2_100.png", density=8.0, friction=1, bounce=0.2, radius=-1,x=0 }
--	SpriteColection[#SpriteColection + 1] = {type="body",  title="Small Light Brick", image="brick_2_50.png", density=8.0, friction=1, bounce=0.2, radius=-1,x=0 }
	--SpriteColection[#SpriteColection + 1] = {type="body",  title="Large Stone Block", 	image="stone_block_100.png", width=100, height=100, density=20.0, friction=1, bounce=0.2, radius=-1,x=0 }
	--SpriteColection[#SpriteColection + 1] = {type="body",  title="Large Stone Bar", 	image="stone_block_100x50.png", width=100, height=50,density=20.0, friction=1, bounce=0.2, radius=-1,x=0 }
	SpriteColection[#SpriteColection + 1] = {type="body",  title="Old Crock", 			image="crock.png", width=50, height=57, density=5.0, friction=1, bounce=0.2, radius=26,x=0 }
			
--	SpriteColection[#SpriteColection + 1] = { title="LightRoof", image="roof.png", density=4.0, friction=1, bounce=0.2, radius=-1,x=0 }
	--SpriteColection[#SpriteColection + 1] = { title="Beam", image="beam.png", density=12.0, friction=0.3, bounce=0.4, radius=-1,x=0 }
--	SpriteColection[#SpriteColection + 1] = { title="Grey Boulder", image="boulder_grey.png", density=10.0, friction=0.5, bounce=0.4, radius=36,x=0 }
	SpriteColection[#SpriteColection + 1] = {type="body",  title="Small Yellow Boulder", image="boulder_yellow.png", width=37, height=38, density=10.0, friction=0.5, bounce=0.4, radius=18,x=0 }
--]]

-- Run Objects
--[[
	SpriteColection[#SpriteColection + 1] = {type="body",  title="Yellowstone Block", 	image="yellowstone_full_block_a.png", width=32, height=32,density=20.0, friction=1, bounce=0.2, radius=-1,x=0 }	
	SpriteColection[#SpriteColection + 1] = {type="body",  title="Yellowstone Empty Block", 	image="yellowstone_empty_block_a.png", width=32, height=32,density=20.0, friction=1, bounce=0.2, radius=-1,x=0 }	
	

	SpriteColection[#SpriteColection + 1] = {type="body",  title="Yellowstone  Ball", 	image="yellowstone_ball_a.png", width=32, height=32,density=20.0, friction=1, bounce=0.2, radius=16,x=0 }	
	SpriteColection[#SpriteColection + 1] = {type="body",  title="Yellowstone  Bar", 	image="yellowstone_bar_a.png", width=64, height=16,density=20.0, friction=1, bounce=0.2, radius=-1,x=0 }		
	SpriteColection[#SpriteColection + 1] = {type="body",  title="Yellowstone  Long Barl", 	image="yellowstone_long_bar_a.png", width=98, height=16,density=20.0, friction=1, bounce=0.2, radius=-1,x=0 }	
	SpriteColection[#SpriteColection + 1] = {type="body",  title="Stone Block",			 image="stone_block.png", width=32, height=32, density=20.0, friction=1, bounce=0.2, radius=-1,x=0 }
--]]

-- Books
SpriteColection[#SpriteColection + 1] = {type="body",  title="Book1",image="book1.png", width=8, height=35, density=10.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=4,volume=70}
SpriteColection[#SpriteColection + 1] = {type="body",  title="Book2",image="book2.png", width=8, height=35, density=10.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=4,volume=70}
SpriteColection[#SpriteColection + 1] = {type="body",  title="Book3",image="book3.png", width=6, height=26, density=10.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=4,volume=70}
SpriteColection[#SpriteColection + 1] = {type="body",  title="Book4",image="book4.png", width=9, height=39, density=10.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=4,volume=70}
SpriteColection[#SpriteColection + 1] = {type="body",  title="Book5",image="book5.png", width=10, height=82, density=10.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=4,volume=70}
SpriteColection[#SpriteColection + 1] = {type="body",  title="Book6",image="book6.png", width=6, height=49, density=10.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=4,volume=70}


SpriteColection[#SpriteColection + 1] = {type="trap",  title="Trap",image="trap.png", width=89, height=44, density=20.0, friction=100, bounce=0.2, radius=-1,x=0}
	
	
SpriteColection[#SpriteColection + 1] = {type="body",  title="Bascketball",image="bascketball.png", width=30, height=30,density=5.0, friction=1, bounce=0.7, radius=15,x=0,flysound=2,hitsound=3,volume=50}	
SpriteColection[#SpriteColection + 1] = {type="body",  title="Toyball",image="toyball.png", width=32, height=32,density=3.0, friction=1, bounce=0.7, radius=16,x=0,flysound=2,hitsound=3,volume=40}	



SpriteColection[#SpriteColection + 1] = {type="body",  title="Football",image="football.png", width=28, height=28,density=5.0, friction=1, bounce=0.6, radius=14,x=0,flysound=2,hitsound=3,volume=50}	
SpriteColection[#SpriteColection + 1] = {type="body",  title="TennisBall",image="tennisball.png", width=10, height=10,density=5.0, friction=1, bounce=0.8, radius=5,x=0,flysound=4,hitsound=1,volume=50}	


SpriteColection[#SpriteColection + 1] = {type="body",  title="BedStay",image="bedstay.png", width=10, height=64, density=10.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=-1,hitsound=2,volume=40}

SpriteColection[#SpriteColection + 1] = {type="body",  title="BoxRed",image="box_red.png", width=40, height=16, density=2.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=6,volume=70}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BoxBlue",image="box_blue.png", width=26, height=16, density=2.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=6,volume=70}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BoxYellow",image="box_yellow.png", width=50, height=20, density=2.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=6,volume=70}

SpriteColection[#SpriteColection + 1] = {type="body",  title="BagBlue",image="bag_blue.png", shape={-10,-7, -10,-14, 10,-14, 10,-7, 18,14, -18,14}, width=36, height=28, density=3.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=5,volume=60}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BagGreen",image="bag_green.png", width=36, height=32, density=3.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=5,volume=60}

SpriteColection[#SpriteColection + 1] = {type="body",  title="ShoeGoldRight",image="shoe_gold_right.png", width=14, height=18, density=3.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=70}
SpriteColection[#SpriteColection + 1] = {type="body",  title="ShoeGoldLeft",image="shoe_gold_left.png", width=14, height=18, density=3.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=70}

SpriteColection[#SpriteColection + 1] = {type="body",  title="PiramidToy",image="piramidtoy.png", width=26, height=32,shape={ 0,-16,13,16, -13,16 }, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=60}



SpriteColection[#SpriteColection + 1] = {type="body",  title="Slipper",image="slipper.png", width=16, height=8, density=3.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=5,volume=50}


SpriteColection[#SpriteColection + 1] = {type="body",  title="PillowPink",image="pillow.png", width=30, height=90, density=1, friction=1, bounce=0.2, radius=-1,x=0,flysound=2,hitsound=5,volume=40}


SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath1",image="bottle_bath_1.png", width=20, height=34, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath2",image="bottle_bath_2.png", width=14, height=36, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath3",image="bottle_bath_3.png", width=14, height=36, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath4",image="bottle_bath_4.png", width=18, height=28, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath5",image="bottle_bath_5.png", width=14, height=28, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath6",image="bottle_bath_6.png", width=20, height=28, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath7",image="bottle_bath_7.png", width=18, height=34, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath8",image="bottle_bath_8.png", width=18, height=28, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath9",image="bottle_bath_9.png", width=16, height=32, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}
SpriteColection[#SpriteColection + 1] = {type="body",  title="BottleBath10",image="bottle_bath_10.png", width=14, height=34, density=6.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=6,volume=50}


SpriteColection[#SpriteColection + 1] = {type="body",  title="Cheese",image="cheese.png", width=24, height=14, attraction=10, density=5.0, friction=1, bounce=0.2, radius=-1,x=0,flysound=4,hitsound=5,volume=50}

		



end