extends CharacterBody3D
class_name CharacterClick3D

signal picked(node: CharacterClick3D)

@export var speed: float = 100.
@export var avoid_speed: float = 80.
@export var interaction_distance: float = 5.
@export var action_list: Array[SmallTalk]
@export var response_list: Array[SmallResponse]
@export var default_text: String = "Who are you?"

var velocity_xy := Vector2(0.0, 0.0)
var colliding_characters : Array[CharacterClick3D] = []

@onready var interaction_distance_square = interaction_distance * interaction_distance
@onready var appearance: MeshInstance3D = $Appearance
@onready var sentence: Label = %Sentence
@onready var dialogue: Dialogue = $Dialogue

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
	if selected:
		velocity_xy = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	else:
		velocity_xy = Vector2.ZERO
		for character in colliding_characters:
			var delta_distance = global_position -  character.global_position 
			velocity_xy.x += delta_distance.x
			velocity_xy.y += delta_distance.z
		velocity_xy = velocity_xy.normalized() * avoid_speed 
	
func _physics_process(delta: float) -> void:
	velocity.x = velocity_xy.x * delta
	velocity.z = velocity_xy.y * delta
	move_and_slide()
	
func drop() -> void: 
	selected = false
	velocity_xy = Vector2.ZERO

func pick() -> void:
	print("picked ", name)
	selected = true
	
func talked_by(character: CharacterClick3D,  action: SmallTalk) -> bool:
	print("interact")
	if character.position.distance_squared_to(position) > interaction_distance_square:
		character.dialogue.say("Too far")
		return false
	for response in response_list:
		print("trying ", character.response_list.size(), " ", response.small_talk.name)
		if response.small_talk.name == action.name:
			print("found response")
			match response.response_type:
				SmallResponse.RESPONSE_TYPE.GOOD:
					dialogue.say(response.small_talk.good_responses.pick_random())
				SmallResponse.RESPONSE_TYPE.BAD:
					dialogue.say(response.small_talk.bad_responses.pick_random())
				SmallResponse.RESPONSE_TYPE.MEDIUM:
					dialogue.say(response.small_talk.medium_reponses.pick_random())
			return true
	dialogue.say(default_text)
	return true




func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("pick"):
		print("clicked", name)
		picked.emit(self)


func _on_push_area_area_entered(area: Area3D) -> void:
	print("detect other people by", name)
	colliding_characters.push_back(area.get_parent())
	


func _on_push_area_area_exited(area: Area3D) -> void:
	colliding_characters.erase(area.get_parent())
