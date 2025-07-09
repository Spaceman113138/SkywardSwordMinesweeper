class_name Solver
extends Node


static func solveGrid(grid):
	var baseGrid = crateBaseGrid(grid)
	var solvedGrid = checkSimple(grid, baseGrid)
	
	var numMaybe = 0
	for r in solvedGrid:
		for item in r:
			if item != 0 and item != -2:
				numMaybe += 1
	
	var percentSafe = int((4.0 / numMaybe) * 100)
	for r in range(len(solvedGrid)):
		for c in range(len(solvedGrid[0])):
			if solvedGrid[r][c] == -1:
				if percentSafe > solvedGrid[r][c]:
					solvedGrid[r][c] = percentSafe
	
	return solvedGrid


static func crateBaseGrid(grid):
	var rNum = len(grid)
	var cNum = len(grid[0])
	var baseGrid = []
	for r in range(rNum):
		baseGrid.append([])
		for c in range(cNum):
			baseGrid[r].append(-1)
	
	return baseGrid


static func checkSimple(grid, solvedGrid):
	for r in range(len(grid)):
		for c in range(len(grid[0])):
			if grid[r][c] == "None":
				var neighbors = getNeighbors(r, c, grid)
				if neighbors.has("Green"):
					solvedGrid[r][c] = 0
			elif grid[r][c] == "Blue":
				var neighbors = getNeighbors(r, c, grid)
				var num = neighbors.count("Bomb") + neighbors.count("Black")
				var percent = (2.0-num) / numClear(r, c, grid) * 100
				print(percent)
				setSurrounding(r, c, solvedGrid, grid, percent)
				solvedGrid[r][c] = -2
			elif grid[r][c] == "Red":
				var neighbors = getNeighbors(r, c, grid)
				var num = neighbors.count("Bomb") + neighbors.count("Black")
				var percent = (4.0 - num) / numClear(r, c, grid) * 100
				setSurrounding(r, c, solvedGrid, grid, percent)
				solvedGrid[r][c] = -2
			elif grid[r][c] == "Silver":
				var neighbors = getNeighbors(r, c, grid)
				var num = neighbors.count("Bomb") + neighbors.count("Black")
				var percent = (6.0 - num) / numClear(r, c, grid) * 100
				setSurrounding(r, c, solvedGrid, grid, percent)
				solvedGrid[r][c] = -2
			elif grid[r][c] == "Gold":
				var neighbors = getNeighbors(r, c, grid)
				var num = neighbors.count("Bomb") + neighbors.count("Black")
				var percent = (8.0 - num) / numClear(r, c, grid) * 100
				setSurrounding(r, c, solvedGrid, grid, percent)
				solvedGrid[r][c] = -2
			else:
				solvedGrid[r][c] = -2

	return solvedGrid


static func getNeighbors(r, c, grid):
	var neighbors := []
	for rOff in [-1, 0, 1]:
		for cOff in [-1, 0, 1]:
			if rOff != 0 or cOff != 0:
				var newR = r - rOff
				var newC = c - cOff
				if isValidIndex(newR, newC, grid) and grid[newR][newC] != "None":
					neighbors.append(grid[newR][newC])
	
	return neighbors


static func isValidIndex(r, c, grid):
	var rValid = r >= 0 and r < len(grid)
	var cValid = c >= 0 and c < len(grid[0])
	return rValid and cValid

static func numClear(r, c, grid):
	return 8 - len(getNeighbors(r,c,grid))

static func setSurrounding(r, c, solvedGrid, grid, value):
	value = clamp(value, 0, 100)
	for rOff in [-1, 0, 1]:
		for cOff in [-1, 0, 1]:
			if rOff != 0 or cOff != 0:
				var newR = r - rOff
				var newC = c - cOff
				if isValidIndex(newR, newC, grid) and grid[newR][newC] == "None":
					if solvedGrid[newR][newC] == -1 or solvedGrid[newR][newC] > value:
						solvedGrid[newR][newC] = value
