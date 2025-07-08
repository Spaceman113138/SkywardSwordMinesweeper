extends Node2D

var tileSize = 20
const beginner = [5,4]
const intermediate = [6,5]
const expert = [8,5]
var gridSize = beginner

var bombNum = 4
var blackNum = 0

var scene = preload("res://tile.tscn")

var currentValue: float = 0

@onready var UI: TopUI = get_node("Camera2D/CanvasLayer/UI")
@onready var gameOverScreen: Control = get_node("Camera2D/CanvasLayer/gameOver")

func _ready() -> void:
	UI.connect("changeDifficulty", updateDifficulty)
	
	createNewBoard()


func createNewBoard():
	removeBoard()
	
	var board = generateBoard()
	
	var xOffset = 0
	if gridSize[0] % 2 == 1:
		xOffset = tileSize * (floor(gridSize[0] / 2))
	else:
		xOffset = tileSize/2 + ((gridSize[0] / 2.0 - 1) * tileSize)

	var yOffset = 0
	if gridSize[1] % 2 == 1:
		yOffset = tileSize * (floor(gridSize[1] / 2))
	else:
		yOffset = tileSize/2 + ((gridSize[1] / 2.0 - 1) * tileSize)
	
	for r in range(gridSize[1]):
		var nextY = yOffset - tileSize * r
		for c in range(gridSize[0]):
			var tileScene = scene.instantiate()
			tileScene.setContains(board[r][c])
			var nextX = -xOffset + c * tileSize
			tileScene.position = Vector2(nextX, nextY) - Vector2(20, 0)
			tileScene.connect("clicked", contentsUpdate)
			add_child(tileScene)


func generateBoard():
	var board = []
	for r in range(gridSize[1]):
		board.append([])
		for c in range(gridSize[0]):
			board[r].append(10)
	
	#Place bombs
	for i in range(bombNum):
		while true:
			var x = randi_range(0, gridSize[0] - 1)
			var y = randi_range(0, gridSize[1] - 1)
			if board[y][x] == 10:
				board[y][x] = Tile.CAN_CONTAIN.BOMB
				break
	
	for i in range(blackNum):
		while true:
			var x = randi_range(0, gridSize[0] - 1)
			var y = randi_range(0, gridSize[1] - 1)
			if board[y][x] == 10:
				board[y][x] = Tile.CAN_CONTAIN.BLACK
				break
	
	for r in range(gridSize[1]):
		for c in range(gridSize[0]):
			if board[r][c] == 10:
				match numNeighborBad(board, r, c):
					0:
						board[r][c] = Tile.CAN_CONTAIN.GREEN
					1, 2:
						board[r][c] = Tile.CAN_CONTAIN.BLUE
					3,4:
						board[r][c] = Tile.CAN_CONTAIN.RED
					5,6:
						board[r][c] = Tile.CAN_CONTAIN.SILVER
					7,8:
						board[r][c] = Tile.CAN_CONTAIN.GOLD
	
	print(board)
	return board


func numNeighborBad(board, r, c):
	var numBad = 0
	for rO in [-1, 0, 1]:
		for cO in [-1, 0 ,1]:
			if rO != 0 or cO != 0:
				var contents = board[rO + r][cO + c] if validIndex(board, r + rO, c + cO) else 10
				if contents == Tile.CAN_CONTAIN.BOMB or contents == Tile.CAN_CONTAIN.BLACK:
					numBad += 1
	print(numBad)
	return numBad


func validIndex(board, r, c):
	var validR = r >= 0 and r < len(board)
	var validC = c >= 0 and c < len(board[0])
	return validR and validC


func revealAll():
	var children = get_children()
	for child in children:
		if child is Tile:
			child.reveal()


func contentsUpdate(value:float):
	if value == 0:
		print("Game Over")
		revealAll()
		gameOverScreen.visible = true
	else:
		currentValue += value
		UI.updateRupesMade(currentValue)
		print(currentValue)


func removeBoard():
	for child in get_children():
		if child is Tile:
			remove_child(child)


func updateDifficulty(newDifficulty: String):
	if newDifficulty == "beginner":
		gridSize = beginner
		bombNum = 4
		blackNum = 0
	elif newDifficulty == "intermediate":
		gridSize = intermediate
		bombNum = 4
		blackNum = 4
	else:
		gridSize = expert
		bombNum = 8
		blackNum = 8
	
	createNewBoard()


func _on_restart_button_pressed() -> void:
	gameOverScreen.visible = false
	createNewBoard()
	UI.updateRupesMade(0)
