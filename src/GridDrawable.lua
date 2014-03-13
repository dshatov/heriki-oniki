function drawObjects(x_offset, y_offset, zoom)
	for x = 0, 2 do
		for y = 0, 2 do
			if Grid.getPoint(x, y) == 'x' then
				love.graphics.line(x_offset + x * zoom, y_offset + y * zoom, x_offset + (x + 1) * zoom, y_offset + (y + 1) * zoom)
				love.graphics.line(x_offset + (x + 1) * zoom, y_offset + y * zoom, x_offset + x * zoom, y_offset + (y + 1) * zoom)
			elseif Grid.getPoint(x, y) == 'o' then
				love.graphics.circle("line", x_offset + (x + 0.5) * zoom, y_offset + (y + 0.5) * zoom, zoom / 2, 100)
			end
		end
	end
end

function drawGrid(x_offset, y_offset, zoom, width, height)
	local lineCount = math.floor((WINDOW_WIDTH - x_offset * 2) / zoom)
	for i = 0, lineCount do
		love.graphics.line(x_offset + i * zoom, y_offset, x_offset + i * zoom, y_offset + zoom * lineCount)
		love.graphics.line(x_offset, y_offset + i * zoom, x_offset + zoom * lineCount, y_offset + i * zoom)
	end
end

