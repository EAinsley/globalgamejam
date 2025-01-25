extends Area2D

signal clicked

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("pick"):
			clicked.emit()
