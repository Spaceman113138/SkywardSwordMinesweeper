class_name Tile
extends Area2D

enum CAN_CONTAIN {BOMB = 0, GREEN = 1, BLUE = 5, RED = 20, BLACK = -10, SILVER = 100, GOLD = 300}
var type: String = ""
var contents:CAN_CONTAIN

var mouseHovering: bool = false
var hasBeenClicked: bool = false

signal clicked(contents:float)

@onready var containsSprite: Sprite2D = get_child(3)


func setContains(contains: CAN_CONTAIN) -> void:
	containsSprite = get_child(3)
	contents = contains
	
	match contains:
		CAN_CONTAIN.BOMB:
			type = "Bomb"
		CAN_CONTAIN.GREEN:
			type = "Green"
		CAN_CONTAIN.BLUE:
			type = "Blue"
		CAN_CONTAIN.RED:
			type = "Red"
		CAN_CONTAIN.BLACK:
			type = "Black"
		CAN_CONTAIN.SILVER:
			type = "Silver"
		CAN_CONTAIN.GOLD:
			type = "Gold"

	if type == "Bomb":
		var path := "res://rupe icons/SS-Bomb.png"
		var texture: Texture2D = load(path)
		containsSprite.texture = texture
		containsSprite.scale = Vector2(0.088, 0.088)
	else:
		var path = "res://rupe icons/SS-" + type + "Rupee.png"
		var texture: Texture2D = load(path)
		containsSprite.texture = texture
		if type == "Black" or type == "Gold":
			containsSprite.scale = Vector2(0.015, 0.015)
		else:
			containsSprite.scale = Vector2(0.028, 0.028)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed == false and mouseHovering and hasBeenClicked == false:
			hasBeenClicked = true
			onClicked()


func reveal():
	containsSprite.visible = true


func onClicked():
	containsSprite.visible = true
	clicked.emit(contents)


func _on_mouse_entered() -> void:
	mouseHovering = true


func _on_mouse_exited() -> void:
	mouseHovering = false
