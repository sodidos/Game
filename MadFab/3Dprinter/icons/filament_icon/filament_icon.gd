extends Area2D

var selected = false
var return_to_origin = false
var initial_position
var placed = false
@export var printer: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	if selected and not return_to_origin:
		# Follow Mouse
		global_position = lerp(global_position, get_global_mouse_position(), printer.move_speed * delta)
	if return_to_origin:
		global_position = lerp(global_position, initial_position, printer.return_to_origin_speed * delta)
		if global_position.distance_to(initial_position) < 1:
			return_to_origin = false
			placed = false
			printer.filament.placed = false

func _on_input_event(_viewport, event, _shape_idx):
	if not return_to_origin:
		var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
		if(!is_drag and event.is_pressed()):
			selected = true
		if(!is_drag and !event.is_pressed()):
			print("Unselected")
			selected = false
			return_to_origin = true

func reset():
	placed = false
	selected = false
	return_to_origin = false
	global_position = initial_position
	printer.filament.visible = false
	input_pickable = true
	visible = true

func _on_area_entered(area):
	if area.name == "SpoolHolder" and not placed:
		visible = false
		input_pickable = false
		global_position = initial_position
		placed = true
		selected = false
		printer.filament.visible = true

func _on_spool_holder_area_entered(_area):
	pass # Replace with function body.
