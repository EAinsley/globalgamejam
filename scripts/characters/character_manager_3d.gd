extends Node3D
class_name CharacterManager3D

var character_picked : CharacterClick3D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pick"):
		if character_picked:
			character_picked.drop()
			character_picked = null

func _on_character_picked(new_character: CharacterClick3D) -> void:
	print("on character picked")
	if character_picked and character_picked == new_character:
		return
	if character_picked:
		character_picked.drop()
		
	new_character.pick()
	character_picked = new_character
