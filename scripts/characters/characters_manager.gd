extends Node2D
class_name CharacterManager

var selected: CharacterClick

func _on_charcater_picked(character: CharacterClick) -> void:
	if selected:
		selected.drop()
	selected = character
