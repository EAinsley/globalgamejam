extends Button

@export var first_level: PackedScene

func _on_pressed() -> void:
	print("change scene to ", first_level.resource_name)
	SceneManager.change_scene(1., first_level, 5.)
	
