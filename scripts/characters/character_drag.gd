extends RigidBody2D

var held = false

func _physics_process(delta):
	if held:
		global_transform.origin = lerp(global_transform.origin, get_global_mouse_position(), delta * 20)
		if Input.is_action_just_released("pick"):
			drop()
	

func _on_click_area_clicked() -> void:
	held = true

func drop() -> void:
	held = false
	


func _on_body_entered(body: Node) -> void:
	print("body entered")
	body.apply_central_impulse(global_transform.origin - body.global_transform.origin)
