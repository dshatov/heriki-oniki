function love.load()
	Grid = {}
	for i = 0, 2 do
		Grid[i] = {}
	end
	CurPlayer = 'x'
end

function checkLine(pt, dir, len)
	if pt.x + dir.dx * (len - 1) > 2 or
			pt.x + dir.dx * (len - 1) < 0 or
			pt.y + dir.dy * (len - 1) > 2 or
			pt.y + dir.dy * (len - 1) < 0 then
		return nil
	else
		local owner = Grid[pt.x][pt.y]
		for i = 1, len - 1 do
			if Grid[pt.x + dir.dx * i][pt.y + dir.dy * i] ~= owner then
				return nil
			end
		end
		return owner
	end
end

function checkEndOfGame()
	for x = 0, 2 do
		for y = 0, 2 do
			for dx = -1, 1 do
				for dy = -1, 1 do
					if dx ~= 0 or dy ~= 0 then
						Winner = checkLine({x=x, y=y}, {dx=dx, dy=dy}, 3)
						if Winner ~= nil then
							return
						end
					end
				end
			end
		end
	end
end

function love.mousepressed(x, y, button)
	if button == "l" and Winner == nil then
		LastMouse = {}
		LastMouse.x = x
		LastMouse.y = y
	end
end

function love.mousereleased(x, y, button)
	if button == "l" and LastMouse ~= nil then
		if LastMouse.x == x and LastMouse.y == y then
			local logic_x = math.floor((x - 16) / 128)
			local logic_y = math.floor((y - 16) / 128)
			LastMouse = nil
			if logic_x >= 0 and logic_x < 3 and logic_y >= 0 and logic_y < 3 then
				if Grid[logic_x][logic_y] == nil then
					Grid[logic_x][logic_y] = CurPlayer
					checkEndOfGame()
					if CurPlayer == 'x' then
						CurPlayer = 'o'
					else
						CurPlayer = 'x'
					end
				end
			end
		end
	end
end

function drawObjects(x_offset, y_offset, zoom)
	for x = 0, 2 do
		for y = 0, 2 do
			if Grid[x][y] == 'x' then
				love.graphics.line(x_offset + x * zoom, y_offset + y * zoom, x_offset + (x + 1) * zoom, y_offset + (y + 1) * zoom)
				love.graphics.line(x_offset + (x + 1) * zoom, y_offset + y * zoom, x_offset + x * zoom, y_offset + (y + 1) * zoom)
			elseif Grid[x][y] == 'o' then
				love.graphics.circle("line", x_offset + (x + 0.5) * zoom, y_offset + (y + 0.5) * zoom, zoom / 2, 100)
			end
		end
	end
end

function drawGrid(x_offset, y_offset, zoom, width, height)
	for i = 0, width do
		love.graphics.line(x_offset + i * zoom, y_offset, x_offset + i * zoom, y_offset + zoom * width)
	end
	for i = 0, height do
		love.graphics.line(x_offset, y_offset + i * zoom, x_offset + zoom * height, y_offset + i * zoom)
	end
end

function love.draw()
	love.graphics.setColor(128, 0, 0, 255)
	drawGrid(16, 16, 128, 3, 3)

	love.graphics.setColor(0, 128, 0, 255)
	drawObjects(16, 16, 128)
	love.graphics.setColor(255, 255, 255, 255)
	if Winner ~= nil then
		love.graphics.print('Winner: ' .. Winner, 16, 408)
	else
		love.graphics.print('Current: ' .. CurPlayer, 16, 408)
	end
end