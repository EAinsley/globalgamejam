extends TextureRect

var elapsed_time: float
@onready var base_roatation := rotation

func _process(delta: float) -> void:
	elapsed_time += delta
	scale = (1.0 + 0.02 * sin(2.5 * elapsed_time)) * Vector2.ONE
	rotation = base_roatation +  0.01 * sin(2. * elapsed_time)
