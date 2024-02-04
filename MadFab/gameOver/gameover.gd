extends Node2D

var selected = false
var main: Node2D
var accept_input = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(viewport, event, shape_idx):
	if accept_input:
		var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
		if(!is_drag and event.is_pressed()):
			selected = true
		if(!is_drag and !event.is_pressed()):
			selected = false
			queue_free()
			main.resetTimer()
			main.resetScore()
			main.loadGame(main.LEVELING)

func _on_timer_timeout():
	accept_input = true
