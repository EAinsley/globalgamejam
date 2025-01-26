extends Area3D
class_name Bubble

var bubble_tween: Tween
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var bubble: MeshInstance3D = $Bubble
@onready var bubble_collision_radius_base = collision_shape_3d.shape.radius

func change_bubble_size(multiplier: float, duration: float):
	collision_shape_3d.disabled = true
	collision_shape_3d.shape.radius = bubble_collision_radius_base * multiplier
	if bubble_tween:
		bubble_tween.stop()
	bubble_tween = get_tree().create_tween()
	bubble_tween.tween_property(bubble, "scale", Vector3.ONE * multiplier, duration).set_trans(Tween.TRANS_BOUNCE)
	bubble_tween.tween_callback(func(): collision_shape_3d.disabled = false)
	
