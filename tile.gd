class_name Tile
extends Area2D

enum CAN_CONTAIN {BOMB = 0, GREEN = 1, BLUE = 2, RED = 3, BLACK = 4, SILVER = 5, GOLD = 6}
var type: String = ""

var mouseHovering: bool = false

@onready var containsSprite: Sprite2D = get_child(3)


func setContains(contains: CAN_CONTAIN) -> void:
	containsSprite = get_child(3)
	
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
	else:
		var path = "res://rupe icons/SS-" + type + "Rupee.png"
		var texture: Texture2D = load(path)
		containsSprite.texture = texture
		containsSprite.scale = Vector2(0.015, 0.015)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed == false and mouseHovering:
			clicked()


func clicked():
	print("clicked")
	containsSprite.visible = true


func _on_mouse_entered() -> void:
	mouseHovering = true


func _on_mouse_exited() -> void:
	mouseHovering = false
