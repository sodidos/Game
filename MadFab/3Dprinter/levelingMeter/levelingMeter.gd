extends Control

var score = 0
@export var paper: Area2D
@export var markerLevel: Area2D
@export var global: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_score():
	score = score + 1
	change_score()
	if(score == 4):
		global.reset()
		global.main.change_score(global.main.get_score() + 1)

func reset_score():
	score = 0
	change_score()

func change_position():
	markerLevel.global_position.y = paper.global_position.y
	markerLevel.global_position.x = randi_range(paper.global_position.x, paper.global_position.x + 100)

func change_score():
	match score:
		0:
			$ok1.color = Color(0,0,0)
			$ok2.color = Color(0,0,0)
			$ok3.color = Color(0,0,0)
			$ok4.color = Color(0,0,0)
		1:
			$ok1.color = Color(0,255,0)
			$ok2.color = Color(0,0,0)
			$ok3.color = Color(0,0,0)
			$ok4.color = Color(0,0,0)
		2:
			$ok1.color = Color(0,255,0)
			$ok2.color = Color(0,255,0)
			$ok3.color = Color(0,0,0)
			$ok4.color = Color(0,0,0)
		3:
			$ok1.color = Color(0,255,0)
			$ok2.color = Color(0,255,0)
			$ok3.color = Color(0,255,0)
			$ok4.color = Color(0,0,0)
		4:
			$ok1.color = Color(0,255,0)
			$ok2.color = Color(0,255,0)
			$ok3.color = Color(0,255,0)
			$ok4.color = Color(0,255,0)
			
