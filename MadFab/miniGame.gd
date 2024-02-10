extends Node2D

const PRINTER3D = "res://3Dprinter/3Dprinter.tscn"
const LASER = "res://laser/laser.tscn"
const CNC = "res://cnc/cnc.tscn"
var machine = PRINTER3D

const PRINTER3D_LEVELING = 0
const PRINTER3D_FILAMENT = 1
const PRINTER3D_PRINT = 2
const PRINTER3D_STUCKFILAMENT = 3
const PRINTER3D_HOTENDREPLACEMENT = 4

var action = PRINTER3D_FILAMENT

var instance
@export var TimerMeter: Control
@export var Seconds: Timer
var score = 0

signal restartGame()

# Called when the node enters the scene tree for the first time.
func _ready():
	loadGame()
	Seconds.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func resetTimer():
	Seconds.start()
	TimerMeter.reset()

func loadGame():
	var scene = load(machine)
	instance = scene.instantiate()
	instance.main = self
	instance.action = PRINTER3D_FILAMENT
	add_child(instance)

func gameOver():
	instance = load("res://gameOver/gameover.tscn").instantiate()
	instance.main = self
	add_child(instance)

func _on_seconds_timeout():
	if(TimerMeter.move_bar()):
		instance.queue_free()
		Seconds.stop()
		gameOver()

func change_score(new_score):
	TimerMeter.change_score(new_score)

func get_score():
	return TimerMeter.score

func resetScore():
	TimerMeter.change_score(0)
