-- LövePotion example/no game screen
require("3ds")
-- love.load() is called once when a LövePotion game is ran.
function love.load()


	-- Seeds the random number generator with the time (Actually makes it random)
	math.randomseed(os.time())

	 -- Sets the current screen for draw calls to draw to.
	 -- Lasts until it is called again.
	love.graphics.setScreen('top')
	
	  highscore = 0
     -- love.filesystem.setIdentity( "score.lua" )
     -- highscore = love.filesystem.read( "score.lua" )
     -- highscore = tonumber( highscore )



-- Grafiken laden
titletop = love.graphics.newImage( "tiles/titlescreen.png" )
titlebottom = love.graphics.newImage( "tiles/controlls.png" )

bg = love.graphics.newImage( "tiles/bg.png" )
gui = love.graphics.newImage( "tiles/gui.png" )
fuelicon = love.graphics.newImage( "tiles/fuel.png" )
box = love.graphics.newImage( "tiles/box.png" )
--Rocket
rocket = love.graphics.newImage( "tiles/rocketright.png" )
rocketup = love.graphics.newImage( "tiles/rocketup.png" )
rocketdown = love.graphics.newImage( "tiles/rocketdown.png" )
rocketleft = love.graphics.newImage( "tiles/rocketleft.png" )
rocketright = love.graphics.newImage( "tiles/rocketright.png" )
--Gegner
rockone = love.graphics.newImage( "tiles/rockone.png" )
rocktwo = love.graphics.newImage( "tiles/rocktwo.png" )
rockthree = love.graphics.newImage( "tiles/rockthree.png" ) 
ufored = love.graphics.newImage( "tiles/ufored.png" )
ufoblue = love.graphics.newImage( "tiles/ufoblue.png" )
ufogreen = love.graphics.newImage( "tiles/ufogreen.png" )
ufoyellow = love.graphics.newImage( "tiles/ufoyellow.png" )

--Animation, Explosion
animation = love.graphics.newImage("tiles/explosion.png")
frame={}
frame[0] = love.graphics.newQuad(0, 0, 1, 1, 640, 600)
frame[1] = love.graphics.newQuad(0, 0, 160, 120, 640, 600)
frame[2] = love.graphics.newQuad(160, 0, 160, 120, 640, 600)
frame[3] = love.graphics.newQuad(320, 0, 160, 120, 640, 600)
frame[4] = love.graphics.newQuad(480, 0, 160, 120, 640, 600)
frame[5] = love.graphics.newQuad(0, 120, 160, 120, 640, 600)
frame[6] = love.graphics.newQuad(160, 120, 160, 120, 640, 600)
frame[7] = love.graphics.newQuad(320, 120, 160, 120, 640, 600)
frame[8] = love.graphics.newQuad(480, 120, 160, 120, 640, 600)
frame[9] = love.graphics.newQuad(0, 240, 160, 120, 640, 600)
frame[10] = love.graphics.newQuad(160, 240, 160, 120, 640, 600)
frame[11] = love.graphics.newQuad(320, 240, 160, 120, 640, 600)
frame[12] = love.graphics.newQuad(480, 240, 160, 120, 640, 600)
frame[13] = love.graphics.newQuad(0, 360, 160, 120, 640, 600)
frame[14] = love.graphics.newQuad(160, 360, 160, 120, 640, 600)
frame[15] = love.graphics.newQuad(320, 360, 160, 120, 640, 600)
frame[16] = love.graphics.newQuad(480, 360, 160, 120, 640, 600)
frame[17] = love.graphics.newQuad(0, 480, 160, 120, 640, 600)
frame[18] = love.graphics.newQuad(160, 480, 160, 120, 640, 600)
frame[19] = love.graphics.newQuad(320, 480, 160, 120, 640, 600)
frame[20] = love.graphics.newQuad(480, 480, 160, 120, 640, 600)


-- Schriftarten laden
   fontsmall = love.graphics.newFont("pixel.ttf",18)
   fontlarge = love.graphics.newFont("pixel.ttf", 30)

-- Sound Laden
   explosion = love.audio.newSource("boom.wav", "static")
   --explosion:setVolume(2.0)
-- crash = love.audio.newSource("sounds/crash.ogg", "static")
 --  blob = love.audio.newSource("blob.wav", "static")

-- Spiel
size = 20 -- Darf nicht mehr Verändert Werden !!!!
kiway = 0
score = 0
scorewert = 10
neuboni = 999999999
bonilengh = -1
boniend = 0
gamestate = "title"
boni = 0 
effect = 0
--fuelwert = 50 -- Wird unten bei der "else" anweisung der Boni geregelt !
stop = "false"
framecount = 0
blink = 0
blinktext = "true"
fuelneg = 1

--Boni
enemystate = "visible"
fuelboni = 0

--Spieler
x = math.random(0/size, 380/size)*size
y = math.random(0/size, 220/size)*size
zuege = 0
fuel = 100
--Box
bx = math.random(0/size, 380/size)*size
by = math.random(0/size, 220/size)*size
--Gegner
kx = math.random(0/size, 380/size)*size
ky = math.random(0/size, 220/size)*size

	
	--Grafik Ermitteln
enemyrand = math.random(1, 7)
if enemyrand == 1 then
enemy = rockone
elseif enemyrand == 2 then
enemy = rocktwo
elseif enemyrand == 3 then
enemy = rockthree
elseif enemyrand == 4 then
enemy = ufored
elseif enemyrand == 5 then
enemy = ufoblue
elseif enemyrand == 6 then
enemy = ufogreen
elseif enemyrand == 7 then
enemy = ufoyellow
end



end

-- love.keypressed is called when any button is pressed.
-- The argument key is the key that was pressed.
-- Not all input code goes here, if you want to check if a button is down then
-- use love.update(dt) along with love.keyboard.isDown().
function love.keypressed(key)
	--If the start button is pressed, we return to the Homebrew Launcher
	if key == 'start' then
		love.event.quit()
	end
	if gamestate == "title" then
		if key == "a" then							-- Objekt zufällig bewegen (Warp)
			gamestate = "game"
			score = 0
		     bx = math.random(0/size, 380/size)*size
	         by = math.random(0/size, 220/size)*size
		end 
	end
	
	if gamestate == "game" then

		if key == "up" or key == "down" or key == "left" or key == "right" then
			--blob:play()
			kiway = math.random(1, 5)
		end
		-- Spieler Steuerung
		if key == "up" and y-size > -size then
			y = y-size
			fuel = fuel-fuelneg
			rocket = rocketup
			zuege = zuege+1
			round = "done"
			stop = "true"
		elseif key == "down" and y+size < 240 then
			y = y+size
			fuel = fuel-fuelneg
			rocket = rocketdown
			zuege = zuege+1
			round = "done"
			stop = "true"
		elseif key == "left" and x-size > -size then
			x = x-size
			fuel = fuel-fuelneg
			rocket = rocketleft
			zuege = zuege+1
			round = "done"
			stop = "true"
		elseif key == "right" and x+size < 400 then
			x = x+size
			fuel = fuel-fuelneg
			rocket = rocketright
			zuege = zuege+1
			round = "done"
			stop = "true"
		elseif key == "a" then							-- Objekt zufällig bewegen (Warp)
			x = math.random(0/size, 380/size)*size
			y = math.random(0/size, 220/size)*size
			fuel = fuel-5
			zuege = zuege+1
			round = "done"
			stop = "true"
		else 
			stop = "false"
		end


-- Gegner Steuerung
		if kiway == 1 and ky-size > -size and stop == "true" then
			stop = "true"
			ky = ky-size
		elseif kiway == 2 and ky+size < 240 and stop == "true"  then
			stop = "true"
			ky = ky+size
		elseif kiway == 3 and kx-size > -size and stop == "true" then
			stop = "true"
			kx = kx-size
		elseif kiway == 4 and kx+size < 400 and stop == "true" then
			stop = "true"
			kx = kx+size
		elseif kiway == 5 and kx+size < 400 and stop == "true" then
			stop = "true"
			kx = kx
			ky = ky
		end


	end
	

end

-- love.draw() is called every frame. Any and all draw code goes here. (images, shapes, text etc.)
function love.draw()

	-- Start drawing to the top screen
	if gamestate == "game" then
	love.graphics.setColor(255,255,255)
		 love.graphics.setScreen('top')
			love.graphics.draw(bg , 0 , 0)
			love.graphics.setColor(255,255,255)
			love.graphics.draw(rocket , x , y)
			
			--Box
			love.graphics.setColor(255,255,255)
			--love.graphics.rectangle("fill", x, y, size,size)
			love.graphics.draw(box , bx , by)
		
			if enemystate == "visible" then
				love.graphics.setColor(255,255,255)
				--love.graphics.rectangle("fill", kx, ky, size,size)
				love.graphics.draw(enemy , kx , ky)
			end
			
			love.graphics.draw(animation, frame[framecount] , x-70, y-50)
			
			
			
	     love.graphics.setScreen('bottom')
		    love.graphics.setFont(fontsmall);
			love.graphics.draw(gui , 0 , 0)
			love.graphics.draw(fuelicon , 107 , 175)
			love.graphics.draw(box , 81 , 212)
			-- Guitext
			--love.graphics.setFont(guifont);
			love.graphics.setColor(	50,205,50)
			love.graphics.print("Fuel:" .. fuel .. " ", 130, 173)
			love.graphics.print(effect, 104, 209)
			--love.graphics.print("Boni:" .. neuboni .. " Zuege" .. zuege ..  " ", 40, 570)
			love.graphics.setColor(	255,255,255)
			love.graphics.draw(rocket , 25 , 160)
			love.graphics.setColor(	50,205,50)
			love.graphics.print("X:" .. x .. " ", 13, 183)
			love.graphics.print("Y:" .. y .. " ", 13, 210)
			love.graphics.setColor(	255,255,255)
			love.graphics.draw(enemy , 275 , 160)
			love.graphics.setColor(	50,205,50)
			love.graphics.print("X:" .. kx .. " ", 260, 183)
			love.graphics.print("Y:" .. ky .. " ", 260, 210)
			
			love.graphics.setFont(fontlarge);
            love.graphics.print(score, 85, 60)
			
			love.graphics.setFont(fontsmall);
			love.graphics.setColor(	0,61,245)
			love.graphics.print(highscore, 100, 120)
		
	end
	
	if gamestate == "title" then
	love.graphics.setColor(255,255,255)
		love.graphics.setScreen('top')
			love.graphics.draw(titletop , 0 , 0)
			if score > 0 then
			love.graphics.setFont(fontlarge);
			love.graphics.setColor(	0,61,245)
			love.graphics.print("Score: " .. score .. " ", 130, 135)
			love.graphics.setColor(255,255,255)
			end
		love.graphics.setScreen('bottom')
			love.graphics.draw(titlebottom , 0 , 0)
	end



end

-- love.update(dt) is called every frame, and is used for game logic.
-- The dt argument is delta-time, the average time between frames.
-- Use this to make your game framerate independent.
function love.update(dt)



	--Bei Treffer
	if x == kx and y == ky then
	--fuelwert = 40
	fuel = fuel+fuelwert
	score = score+scorewert
	explosion:play()
	hit = "true"
		-- Animation erstellen
		if hit == "true" then
			framecount = framecount+1
			if framecount > 20 then
			hit = "false"
			framecount = 0
			end
		end
	-- Neue Position Ermitteln
	kx = math.random(0/size, 380/size)*size
	ky = math.random(0/size, 220/size)*size
		--Grafik Ermitteln
		enemyrand = math.random(1, 7)
		if enemyrand == 1 then
		enemy = rockone
		elseif enemyrand == 2 then
		enemy = rocktwo
		elseif enemyrand == 3 then
		enemy = rockthree
		elseif enemyrand == 4 then
		enemy = ufored
		elseif enemyrand == 5 then
		enemy = ufoblue
		elseif enemyrand == 6 then
		enemy = ufogreen
		elseif enemyrand == 7 then
		enemy = ufoyellow
		end
	
	end
	
	-- Treffer Animation
	if hit == "true" then
	framecount = framecount+1
		if framecount > 20 then
		hit = "false"
		framecount = 0
		end
	end
	
	-- Kiste 1
	if x == bx and y == by then
	--love.audio.play(crash)
	score = score+scorewert/2
	neuboni = zuege+40
	bonilengh = zuege+30
	boni = math.random(1, 5)
	bx = -20
	by = -20
	end
	
    --Bei Spiel Ende
	if fuel <= 0 then
	rocket = rocketright
	fuel = 100
	x = 0
	y = 0
	bonilengh = -1
	zuege = 0
	gamestate = "title"
	--fuelwert = 40
	enemystate = "visible"
	fuelneg = 1
	fuelboni = 0
	effect = " / "
		if score > highscore then
		highscore = score
	--	highscore = love.filesystem.read( "score.lua")
	--	highscore = tonumber( highscore )
	--	newcontent = love.filesystem.write(  "score.lua", score)
	--	highscore = love.filesystem.read( "score.lua")
		end
	end
	
	-- Nach Boni Ablauf
	if neuboni <= zuege then
	neuboni = 999999999
	bx = math.random(0/size, 380/size)*size
	by = math.random(0/size, 220/size)*size
	end
	
	-- Liste der Boni   WICHTIG, auch beim neustart zurücksetzten!!!!
	if boni == 1 and bonilengh >= zuege then
	enemystate = "invisible"
	scorewert = 100
	effect = "Invisible Bot"
	elseif boni == 2 and bonilengh >= zuege then
	fuelwert = 20
	effect = "Fuel X2"
	elseif boni == 3 and bonilengh >= zuege then
	scorewert = 20
	effect = "Score X2"
	elseif boni == 4 and bonilengh >= zuege then
	fuelboni = math.random(5,20)
	fuelneg = 2
	effect = "Double consum "
	elseif boni == 5 and bonilengh >= zuege then
	fuelboni = math.random(5,20)
	fuelneg = 0
	effect = "Zero consum "
	else
	fuelboni = 0
	fuelwert = 10
	scorewert = 10
	enemystate = "visible"
	fuelneg = 1
	effect = " / "
	end




end


-- love.quit is called when LövePotion is quitting.
-- You can put all your cleanup code and the likes here.
function love.quit()



end