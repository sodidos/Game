extends Area2D

var selected = false
var placed = false
var initial_position
@export var printer: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = global_position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	pass
	#if selected and not return_to_origin:
		# Follow Mouse
		
		#global_position = lerp(global_position, get_global_mouse_position(), printer.move_speed * delta)
	#if return_to_origin:
		#global_position = lerp(global_position, initial_position, printer.return_to_origin_speed * delta)
		#if global_position.distance_to(initial_position) < 1:
		#	return_to_origin = false

func _on_input_event(_viewport, event, _shape_idx):
	var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
	if(!is_drag and event.is_pressed()):
		selected = true
		reset()
		placed = false
		printer.paperIcon.visible = true
		printer.paperIcon.input_pickable = true
		printer.paperIcon.selected = true
		printer.paperIcon.global_position = get_global_mouse_position()
		printer.markerLevel.visible = false
	if(!is_drag and !event.is_pressed()):
		selected = false
		global_position = initial_position

func reset():
	placed = false
	selected = false
	global_position = initial_position
	#paper.visible = false
	#input_pickable = false
	#markerLevel.visible = false
	visible = false

