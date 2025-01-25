extends CharacterBody2D
class_name CharacterClick

signal picked(character: CharacterClick)

@export var speed: float = 2000.

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var selected = false :
	set(value) :
		selected = value
		if value:
			sprite_2d.self_modulate = Color(1., 1., 0) 
			picked.emit(self)
		else:
			sprite_2d.self_modulate = Color(0., 0., 0) 

func _enter_tree() -> void:
	var parent = get_parent()
	if parent is CharacterManager:
		picked.connect(parent._on_charcater_picked)

func _physics_process(delta: float) -> void:
	if not selected:
		return
	velocity = Input.get_vector("move_left", "move_right", "move_up","move_down") * delta * speed
	move_and_slide()


func _on_click_area_clicked() -> void:
	print("clicked")
	selected = true

func drop():
	selected = false
