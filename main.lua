function love.load()
	math.randomseed(os.time())
	player = {x = 250, y = 250, vx = 0, vy = 0}
	playeroldx = {}
	playeroldy = {}
	block = {x = math.random(0, 19)*25, y = math.random(0, 19)*25}
	circle = {x = block.x + 12, y = block.y + 12}
	dtotal = 0
	speed = 5
	points = 0
	rot = 0
end

function love.update(dt)
	rot = points + 2
	if points % 10 == 0 then
		speed = 5 + points/10
	end
	dtotal = dtotal + dt*speed
		if dtotal >= 1 then
			repeat
			playeroldx[rot] = playeroldx[rot - 1]
			playeroldy[rot] = playeroldy[rot - 1]
			rot = rot - 1
			until rot == 1
			playeroldx[1] = player.x
			playeroldy[1] = player.y
			player.x = player.x + player.vx
			player.y = player.y + player.vy
			dtotal = dtotal - 1
		end
	if player.x > 475 or player.x < 0 then
		player = {x = 250, y = 250, vx = 0, vy = 0}
		speed = 5
		points = 0
	end
	if player.y > 475 or player.y < 0 then
		player = {x = 250, y = 250, vx = 0, vy = 0}
		speed = 5 
		points = 0
	end
	if points >= 3 then
		checkoverlap()
	end
	if player.x == block.x and player.y == block.y then
		block.x = math.random(0, 19)*25
		block.y = math.random(0, 19)*25
		circle.x = block.x + 12
		circle.y = block.y + 12
		points = points + 1
	end
end

function love.draw()
	add = 1
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", player.x, player.y, 25, 25)
	love.graphics.rectangle("fill", block.x, block.y, 25, 25)
	love.graphics.rectangle("line", 0, 0, 500, 500)
	love.graphics.circle("line", circle.x, circle.y, 50, 50)
	if points >= 1 then
		repeat
			love.graphics.setColor(255, 255, 255)
			love.graphics.rectangle("fill", playeroldx[add], playeroldy[add], 25, 25)
			love.graphics.setColor(0, 0, 0)
			love.graphics.rectangle("line", playeroldx[add], playeroldy[add], 25, 25)
			add = add + 1
		until add >= points + 1
	end
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("Score", 600, 100, 0, 1, 1, 0, 0)
	love.graphics.print(points, 600, 120, 0, 1, 1 ,0, 0)
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("line", player.x, player.y, 25, 25)
	
end

function love.keypressed(key)
	if key == 'w' and player.vy == 0 then
		player.vy = -25
		player.vx = 0
	elseif key == 's' and player.vy == 0 then
		player.vy = 25
		player.vx = 0
	elseif  key == 'a' and player. vx == 0 then
		player.vx = -25
		player.vy = 0
	elseif key == 'd' and player.vx == 0 then
		player.vx = 25
		player.vy = 0
	end
end

function checkoverlap()
	check = points
	repeat
		if player.x == playeroldx[check] and player.y == playeroldy[check] then
			player = {x = 250, y = 250, vx = 0, vy = 0}
			speed = 5 
			points = 0
		end
		if check > 3 then
			check = check - 1
		end
	until check == 3
end