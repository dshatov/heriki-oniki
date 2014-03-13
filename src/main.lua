require("Grid")
require("GridDrawable")

function love.load()
	CurZoom = GRID_MAX_ZOOM
	InitGrid()
--	CenterField = {x = 0, y = 0}

	CurPlayer = 'x'
end

function checkLine(pt, dir, len)
	if pt.x + dir.dx * (len - 1) > 2 or
			pt.x + dir.dx * (len - 1) < 0 or
			pt.y + dir.dy * (len - 1) > 2 or
			pt.y + dir.dy * (len - 1) < 0 then
		return nil
	else
		local owner = Grid.getPoint(pt.x, pt.y)
		for i = 1, len - 1 do
			if Grid.getPoint(pt.x + dir.dx * i, pt.y + dir.dy * i) ~= owner then
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
		LastMouse = {x = x, y = y}
	elseif button == "wd" and CurZoom < GRID_MAX_ZOOM then
		CurZoom = CurZoom + 8
	elseif button == "wu" and CurZoom > GRID_MIN_ZOOM then
		CurZoom = CurZoom - 8
	end
end

function love.mousereleased(x, y, button)
	if button == "l" and LastMouse ~= nil then
		if LastMouse.x == x and LastMouse.y == y then
			local logic_x = math.floor((x - GRID_X_OFFSET) / CurZoom)
			local logic_y = math.floor((y - GRID_Y_OFFSET) / CurZoom)
			LastMouse = nil
			if logic_x >= 0 and logic_x < 3 and logic_y >= 0 and logic_y < 3 then
				if Grid.getPoint(logic_x, logic_y) == nil then
					Grid.setPoint(logic_x, logic_y, CurPlayer)
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

function love.draw()
	love.graphics.setColor(64, 128, 64, 255)
	drawGrid(GRID_X_OFFSET, GRID_Y_OFFSET, CurZoom, 3, 3)

	love.graphics.setColor(255, 64, 0, 255)
	drawObjects(GRID_X_OFFSET, GRID_Y_OFFSET, CurZoom)
	love.graphics.setColor(255, 255, 255, 255)
	if Winner ~= nil then
		love.graphics.print('Winner: ' .. Winner, 16, 408)
	else
		love.graphics.print('Current: ' .. CurPlayer, 16, 408)
	end
end
