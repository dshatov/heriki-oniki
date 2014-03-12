function love.load()

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
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print('Hello World!', 400, 300)
end