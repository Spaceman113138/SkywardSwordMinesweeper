class_name SelectionWorld
extends Node2D

const beginner = [4,5]
const intermediate = [5,6]
const expert = [5,8]

var gridSize = beginner
var squareSize = 120
var numSquares = 0

var offset = Vector2(0,0)

@onready var tileScene = preload("res://selectiontile.tscn")

var currentContents = []


func _ready() -> void:
	createGrid()
	for r in range(gridSize[0]):
		currentContents.append([])
		for c in range(gridSize[1]):
			currentContents[r].append("None")
	print(currentContents)


func removeGrid():
	for child in get_children():
		if child is SelectionTile:
			remove_child(child)


func createGrid():
	numSquares = gridSize[0] * gridSize[1]
	var xOffset = -(gridSize[1] * squareSize) / 2 + squareSize / 2
	var yOffset = -(gridSize[0] * squareSize) / 2 + squareSize / 2
	
	for r in range(gridSize[0]):
		for c in range(gridSize[1]):
			var x = c * squareSize + xOffset
			var y = r * squareSize + yOffset
			
			var newTile: SelectionTile = tileScene.instantiate()
			add_child(newTile)
			newTile.position = Vector2(x, y) - offset
			newTile.connect("newContent", updateContents)
			newTile.setGridPos(Vector2(r,c))
			newTile.setPercent(int((4.0 / numSquares) * 100))

func updateContents(gridPos: Vector2, newValue: String):
	currentContents[gridPos.x][gridPos.y] = newValue
	var newSolve = Solver.solveGrid(currentContents)
	for r in range(len(currentContents)):
		for c in range(len(currentContents[0])):
			getTile(Vector2(r, c)).setPercent(newSolve[r][c])


func getTile(atPos: Vector2):
	for child in get_children():
		if child is SelectionTile:
			if child.gridPos == atPos:
				return child
