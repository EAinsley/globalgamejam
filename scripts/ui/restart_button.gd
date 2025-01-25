extends Button


func _on_pressed() -> void:
	print("restart game")
	get_tree().reload_current_scene()
