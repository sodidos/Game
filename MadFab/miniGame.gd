extends Node2D

const LEVELING = 0
var gameType = LEVELING
var instance
@export var TimerMeter: Control
@export var Seconds: Timer
var score = 0

signal restartGame()

# Called when the node enters the scene tree for the first time.
func _ready():
	loadGame(LEVELING)
	Seconds.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func resetTimer():
	Seconds.start()
	TimerMeter.reset()

func loadGame(game):
	var scene = load("res://3Dprinter/3Dprinter.tscn")
	instance = scene.instantiate()
	instance.main = self
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

	
