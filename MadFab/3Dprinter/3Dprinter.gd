extends Node2D

@export var hotEnd: Area2D
@export var paperIcon: Area2D
@export var paper: Area2D
@export var display: Area2D
@export var levelingMeter: Control
var main

func reset():
	paperIcon.reset()
	display.reset()
	hotEnd.reset()
	levelingMeter.reset_score()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

