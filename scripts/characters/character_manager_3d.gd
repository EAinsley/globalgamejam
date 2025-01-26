extends Node3D
class_name CharacterManager3D

@export var next_level: PackedScene

signal won(next_level: PackedScene)

var character_picked : CharacterClick3D
var action_picked: SmallTalk
var charaters_number := 0
var now_inside_number := 0
var action_list_ui: ActionList : 
	get:
		if not action_list_ui:
			action_list_ui = get_tree().get_first_node_in_group("ActionList")
			if action_list_ui:
				action_list_ui.item_selected.connect(_on_action_picked)
		return action_list_ui
		
func register(character: CharacterClick3D):
	print(character.name, " connected to manager")
	character.picked.connect(_on_character_picked)
	charaters_number += 1
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("release"):
		if character_picked:
			character_picked.drop()
			character_picked = null
			action_picked = null
			action_list_ui.clear()



func _on_character_picked(new_character: CharacterClick3D) -> void:
	print("on character picked")
	if character_picked and character_picked == new_character:
		return
	
	if not action_picked:
		if character_picked:
			character_picked.drop()
		new_character.pick()
		character_picked = new_character
	else:
		new_character.talked_by(character_picked, action_picked)
		character_picked.action_list.erase(action_picked)
		action_picked = null
		action_list_ui.replace_list(character_picked.action_list)
	
		
	_set_item_list_ui()
	
func _set_item_list_ui() -> void:
	if not action_list_ui:
		print("no action list")
		return
	action_list_ui.replace_list(character_picked.action_list)
	
func _on_action_picked(action_index: int) -> void:
	var new_action = character_picked.action_list[action_index]
	action_picked = new_action
	print("pick action", action_picked.name)
	


func _on_goal_area_body_entered(body: Node3D) -> void:
	print("manager body entered: ", body.name)
	if body is CharacterClick3D:
		now_inside_number += 1
		print("inside number add")
		if now_inside_number >= charaters_number:
			print("You win")
			won.emit(next_level)


func _on_goal_area_body_exited(body: Node3D) -> void:
	print("manager body exited: ", body.name)
	print("inside number deleted")
	now_inside_number -= 1
