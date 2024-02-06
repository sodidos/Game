extends Area2D

@export var attachedObject: Area2D
@export var display: Area2D

@export var crash_speed = 5
@export var move_speed = 25
var selected = false
var initial_position
var crash = false

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if selected and not crash:
		# Follow Mouse
		global_position = lerp(global_position, get_global_mouse_position(), move_speed * delta)
		# Follow HotEnd (y only)
		attachedObject.global_position.y = global_position.y
	if crash:
		global_position = lerp(global_position, initial_position, crash_speed * delta)
		attachedObject.global_position.y = global_position.y

		if global_position.distance_to(initial_position) < 1:
			crash = false
		
func _on_input_event(viewport, event, shape_idx):
	if not crash:
		var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
		if(!is_drag and event.is_pressed() and display.menu == display.MENU_LEVELING):
			selected = true
		if(!is_drag and !event.is_pressed()):
			selected = false


func _on_area_entered(area):
	if(area.name != "PaperIcon"):
		selected = false
		crash = true

