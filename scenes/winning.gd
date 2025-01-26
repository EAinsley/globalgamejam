extends Control

@export var next_level: PackedScene


func _on_try_again_button_pressed() -> void:
	SceneManager.change_scene(0.2, next_level, 1.0)
