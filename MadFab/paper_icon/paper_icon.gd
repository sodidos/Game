extends Area2D

var selected = false
var return_to_origin = false
var initial_position
@export var move_speed = 50
@export var return_to_origin_speed = 5
@export var paper: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if selected and not return_to_origin:
		# Follow Mouse
		global_position = lerp(global_position, get_global_mouse_position(), move_speed * delta)
	if return_to_origin:
		global_position = lerp(global_position, initial_position, return_to_origin_speed * delta)
		if global_position.distance_to(initial_position) < 1:
			return_to_origin = false
			print("Crash ended")
		
func _on_input_event(viewport, event, shape_idx):
	if not return_to_origin:
		var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
		if(!is_drag and event.is_pressed()):
			selected = true
		if(!is_drag and !event.is_pressed()):
			selected = false


func _on_area_entered(area):
	if area.name == "bed":
		global_position = initial_position
		visible = false
		paper.visible = true
		paper.input_pickable = false
