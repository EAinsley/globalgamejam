
extends Node3D

var time;
var startPos;

func _init():
	time = 0.0;
	startPos = position;

func _process(delta):
	time += delta;
	position = startPos + 1.25 * (-cos(min(time / 5.0, 1.0) * PI) * 0.5 + 0.5) * transform.basis.x;
