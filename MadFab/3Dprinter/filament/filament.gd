extends Area2D

var selected = false
var placed = false
var initial_position
@export var printer: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = global_position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	pass

func _on_input_event(_viewport, event, _shape_idx):
	var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
	print("ispressed")
	if(!is_drag and event.is_pressed()):
		print("pressed")
		selected = true
		reset()
		placed = false
		printer.filamentIcon.visible = true
		printer.filamentIcon.input_pickable = true
		printer.filamentIcon.selected = true
		printer.filamentIcon.global_position = get_global_mouse_position()
	if(!is_drag and !event.is_pressed()):
		selected = false
		global_position = initial_position

func reset():
	placed = false
	selected = false
	global_position = initial_position
	visible = false

