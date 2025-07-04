extends Node2D

var tileSize = 20
var gridSize = [5,4]

var scene = preload("res://tile.tscn")

func _ready() -> void:
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
			tileScene.setContains(randi_range(0, 6))
			var nextX = -xOffset + c * tileSize
			tileScene.position = Vector2(nextX, nextY)
			add_child(tileScene)
