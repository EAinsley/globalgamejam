extends Node3D


func _on_character_manager_3d_won(next_level: PackedScene) -> void:
	SceneManager.change_scene(1.0, next_level, 1.0)
