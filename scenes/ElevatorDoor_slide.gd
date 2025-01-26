
extends AnimatableBody3D

var time;
var startPos;
var closing := false;
var opening := true
var scene: PackedScene

func _init():
	time = 0.0;
	startPos = position;

func _process(delta):
	if closing:
		time += delta;
		position = startPos - 1.25 * (-cos(min(time / 5.0, 1.0) * PI) * 0.5 + 0.5) * transform.basis.x;
		if time >= 5.0:
			closing = false 
	if opening:
		time += delta;
		position = startPos + 1.25 * (-cos(min(time / 5.0, 1.0) * PI) * 0.5 + 0.5) * transform.basis.x;
		if time >= 5.0:
			opening = false


func _on_character_manager_3d_won(next_level: PackedScene) -> void:
	closing = true
	scene = next_level
	startPos = position
	time = 0.0
	SceneManager.change_scene(5.0, scene, 2.0)
	
