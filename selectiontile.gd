class_name SelectionTile
extends Area2D

var currentSelected = "None"

signal newContent(newValue: String)

var gridPos = Vector2.ZERO

@onready var percentLabel: Label = get_node("Label")
@onready var icon: Sprite2D = get_node("Icon")

func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			currentSelected = "None"
		1:
			currentSelected = "Bomb"
		2:
			currentSelected = "Black"
		3:
			currentSelected = "Green"
		4:
			currentSelected = "Blue"
		5:
			currentSelected = "Red"
		6:
			currentSelected = "Silver"
		7:
			currentSelected = "Gold"
	
	icon.visible = true
	percentLabel.visible = false
	
	var image: Texture2D
	if currentSelected == "None":
		icon.visible = false
		percentLabel.visible = true
	elif currentSelected == "Bomb":
		image = load("res://rupe icons/SS-Bomb.png")
		icon.scale = Vector2(0.338, 0.338)
	else: 
		image = load("res://rupe icons/SS-" + currentSelected + "Rupee.png")
		icon.scale = Vector2(0.051, 0.051) if currentSelected == "Black" or currentSelected == "Gold" else Vector2(0.102, 0.102) 
	icon.texture = image
	
	
	
	
	newContent.emit(gridPos, currentSelected)


func setGridPos(newPos: Vector2):
	gridPos = newPos


func setPercent(value: float):
	if currentSelected != "None":
		percentLabel.text = ""
		get_node("MeshInstance2D").modulate = Color8(0,0, 100)
	else:
		percentLabel.text = str(int(value)) + "%"
	if value <= 5:
		get_node("MeshInstance2D").modulate = Color8(6, 150, 43)
	elif value >= 100:
		get_node("MeshInstance2D").modulate = Color8(200, 0, 0)
	elif value <= 50:
		get_node("MeshInstance2D").modulate = Color8(56, 200, 56)
	else:
		get_node("MeshInstance2D").modulate = Color8(242, 87, 79)
