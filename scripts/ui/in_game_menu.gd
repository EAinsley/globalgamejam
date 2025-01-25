extends Control

func _ready() -> void:
	visible = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.is_action_pressed("ui_cancel"):
			if !visible:
				get_tree().paused = true
				visible = true
			else:
				get_tree().paused = false
				visible = false


func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	
