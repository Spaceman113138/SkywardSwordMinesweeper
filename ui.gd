class_name TopUI
extends Control


@onready var rupesMadeLabel: Label = get_node("PanelContainer/HBoxContainer/PanelContainer/rupesMade")

signal changeDifficulty(newDifficulty: String)

func updateRupesMade(newValue: float):
	rupesMadeLabel.text = str(newValue)


func _on_beginner_pressed() -> void:
	changeDifficulty.emit("beginner")


func _on_intermediate_pressed() -> void:
	changeDifficulty.emit("intermediate")


func _on_expert_pressed() -> void:
	changeDifficulty.emit("expert")
