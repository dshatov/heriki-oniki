function InitGrid()
	Grid = {}
	Grid[0] = {}
	Grid.borders = {}
	Grid.borders.top = 0
	Grid.borders.bottom = 0
	Grid.borders.left = 0
	Grid.borders.right = 0

	function Grid.getPoint(x, y)
		if Grid[x] == nil then
			return nil
		else
			return Grid[x][y]
		end
	end

	function Grid.setPoint(x, y, val)
		if Grid[x] == nil then
			Grid[x] = {}
			if Grid.borders.left > x then
				Grid.borders.left = x
			elseif Grid.borders.right < x then
				Grid.borders.right = x
			end
		end
		if Grid.borders.top < y then
			Grid.borders.top = y
		elseif Grid.borders.bottom > y then
			Grid.borders.bottom = y
		end
		Grid[x][y] = val
	end
end
