extends Control

var score = 0
@export var progressTime: ProgressBar
@export var scoreLabel: Label
@export var timeSeconds = 2

var failed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	reset()

func reset():
	progressTime.max_value = timeSeconds
	progressTime.value = timeSeconds

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_bar():
	if progressTime.value == 0:
		return true
	else:
		print(progressTime.value)
		progressTime.value = progressTime.value - 1
		return false
		
func change_score(new_score):
	score = new_score
	scoreLabel.text = str(score)

func get_score():
	return score
