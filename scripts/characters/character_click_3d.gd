extends CharacterBody3D
class_name CharacterClick3D

signal picked(node: CharacterClick3D)

@export var speed: float = 200.

var velocity_xy := Vector2(0.0, 0.0)

@onready var appearance: MeshInstance3D = $Appearance
@onready var selected = false :
	set(value) :
		print("set slected: ", value)
		selected = value
		if value:
			appearance.mesh.material.emission_enabled = true
		else:
			appearance.mesh.material.emission_enabled = false
			
func _enter_tree() -> void:
	var parent = get_parent()
	if parent is CharacterManager3D:
		print("connect to parent")
		picked.connect(parent._on_character_picked)

func _ready() -> void:
	selected = false

func _process(delta: float) -> void:
	velocity_xy = Input.get_vector("move_left", "move_right", "move_up", "move_down") * delta * speed
	
func _physics_process(delta: float) -> void:
	if not selected:
		return
	velocity.x = velocity_xy.x
	velocity.z = velocity_xy.y
	move_and_slide()
	
func drop() -> void: 
	selected = false

func pick() -> void:
	print("picked ", name)
	selected = true


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("pick"):
		print("clicked", name)
		picked.emit(self)
