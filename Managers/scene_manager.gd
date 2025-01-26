extends Node

var scene_change_tween: Tween
@onready var text_rect: ColorRect = $CanvasLayer/TextRect

func change_scene(duration_fade_out: float, next_scene: PackedScene, duration_fade_in: float) -> void:
	if scene_change_tween:
		scene_change_tween.stop()
	scene_change_tween = get_tree().create_tween()
	scene_change_tween.tween_property(text_rect, "color", Color(0, 0, 0, 1), duration_fade_out)
	scene_change_tween.finished.connect(_load_scene.bind(duration_fade_in, next_scene))
	set_process_input(false)
	
func _load_scene(duration: float, next_scene:PackedScene) -> void:
	print("Scene")
	get_tree().paused = false
	set_process_input(true)
	get_tree().change_scene_to_packed(next_scene)
	scene_change_tween = get_tree().create_tween()
	scene_change_tween.tween_property(text_rect, "color", Color(0, 0, 0, 0), duration)
	
