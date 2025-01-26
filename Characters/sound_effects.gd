extends Node
class_name SoundEffects

@export var foot_sound: Array[AudioStream]
@export var response_sound_good: Array[AudioStream]
@export var response_sound_bad: Array[AudioStream]
@export var response_sound_normal: Array[AudioStream]
@export var select_sound: AudioStream

@onready var foot_sound_player: AudioStreamPlayer = $FootSound
@onready var response_player: AudioStreamPlayer = $ResponsePlayer
@onready var select_player: AudioStreamPlayer = $SelectPlayer

@onready var foot_timer: Timer = $FootTimer

func _ready() -> void:
	select_player.stream = select_sound

func play_foot() -> void:
	if not foot_sound_player.playing:
		foot_sound_player.stream = foot_sound.pick_random()
		foot_sound_player.play()

func play_response(response_type: SmallResponse.RESPONSE_TYPE):
	match response_type:
		SmallResponse.RESPONSE_TYPE.GOOD:
			response_player.stream = response_sound_good.pick_random()
		SmallResponse.RESPONSE_TYPE.BAD:
			response_player.stream = response_sound_bad.pick_random()
		SmallResponse.RESPONSE_TYPE.MEDIUM:
			response_player.stream = response_sound_normal.pick_random()
	response_player.play()	

func play_select() -> void:
	select_player.play()
