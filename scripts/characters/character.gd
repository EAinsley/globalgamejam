extends RigidBody2D

var held = false

func _physics_process(delta):
	if held:
		global_transform.origin = lerp(global_transform.origin, get_global_mouse_position(), delta * 10)
		if Input.is_action_just_released("pick"):
			held = false

func _on_click_area_clicked() -> void:
	held = true
