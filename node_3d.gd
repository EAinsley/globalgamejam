
extends Node3D

var time;
var startPos;

func _init():
	time = 0.0;
	startPos = position;

func _process(delta):
	time += delta;
	position = startPos + cos(time * 0.1);
