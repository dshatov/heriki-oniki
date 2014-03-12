function love.load()
	Grid = {}
	for i = 0, 2 do
		Grid[i] = {}
	end

	Grid[0][0] = 'x'
	Grid[1][1] = 'x'
	Grid[2][1] = 'o'
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
	love.graphics.print('Hello World!', 400, 300)
end