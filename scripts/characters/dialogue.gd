extends MeshInstance3D
class_name Dialogue

@onready var sentence: Label = %Sentence
@onready var timer: Timer = $Timer

func say(words: String) -> void:
	sentence.text = words
	visible = true
	timer.start(1.)
	


func _on_timer_timeout() -> void:
	visible = false
