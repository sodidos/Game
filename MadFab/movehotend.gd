extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if(Input.is_action_pressed("ui_right")):
	#	position.x += 1
	#if(Input.is_action_pressed("ui_left")):
	#	position.x -= 1

func _on_clickable_hot_end_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click")
		print("HotEnd Clicked")
