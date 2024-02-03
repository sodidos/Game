extends Area2D

@export var attachedObject: StaticBody2D

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if selected:
		# Follow Mouse
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		# Follow HotEnd (y only)
		attachedObject.global_position.y = global_position.y
		
func _input(event):
	#Detected Mouse Released
	var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
	if(!is_drag and event.is_pressed()):
		selected = true
	if(!is_drag and !event.is_pressed()):
		selected = false
		
