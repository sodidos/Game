extends Node2D

@export var move_speed = 50
@export var return_to_origin_speed = 30
@export var hotEnd: Area2D
@export var paperIcon: Area2D
@export var paper: Area2D
@export var display: Area2D
@export var levelingMeter: Control
@export var bed: Area2D
@export var markerLevel: Area2D
@export var filament: Area2D
@export var filamentIcon: Area2D

var main
var action

func reset():
	paperIcon.reset()
	display.reset()
	hotEnd.reset()
	levelingMeter.reset_score()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

