extends Node
class_name SoundEffects

@export var foot_sound: Array[AudioStream]
@export var response_sound_good: Array[AudioStream]
@export var response_sound_bad: Array[AudioStream]
@export var response_sound_normal: Array[AudioStream]
@export var select_sound: AudioStream

@onready var foot_sound_player: AudioStreamPlayer = $FootSoundPlayer
@onready var response_player: AudioStreamPlayer = $ResponsePlayer
@onready var select_player: AudioStreamPlayer = $SelectPlayer

func _ready() -> void:
	select_player.stream = select_sound

func play_foot() -> void:
	if foot_sound.is_empty():
		return
	if not foot_sound_player.playing:
		foot_sound_player.stream = foot_sound.pick_random()
		foot_sound_player.play()

func play_response(response_type: SmallResponse.RESPONSE_TYPE):
	match response_type:
		SmallResponse.RESPONSE_TYPE.GOOD:
			if response_sound_good.is_empty(): return
			response_player.stream = response_sound_good.pick_random()
		SmallResponse.RESPONSE_TYPE.BAD:
			if response_sound_good.is_empty(): return
			response_player.stream = response_sound_bad.pick_random()
		SmallResponse.RESPONSE_TYPE.MEDIUM:
			if response_sound_good.is_empty(): return
			response_player.stream = response_sound_normal.pick_random()
	response_player.play()	

func play_select() -> void:
	select_player.play()
