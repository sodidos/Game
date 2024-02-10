extends Area2D

@export var attachedObject: Area2D
@export var display: Area2D
@export var levelingMeter: Control
@export var bed: Area2D

@export var crash_speed = 25
@export var move_speed = 50

# Save original position
var initial_position

# Is HotEnd Drag
var selected = false
# Is HotEnd has been in a collision
var crash = false

func reset():
	global_position = initial_position
	crash = false
	selected = false
	levelingMeter.reset_score()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Backup position before moving
	initial_position = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if selected and not crash:
		# Follow Mouse
		global_position = lerp(global_position, get_global_mouse_position(), move_speed * delta)
		# Axis follow HotEnd (y only)
		attachedObject.global_position.y = global_position.y
	if crash:
		# Go Back to original Position
		global_position = lerp(global_position, initial_position, crash_speed * delta)
		attachedObject.global_position.y = global_position.y
		# Orignal position reached
		if global_position.distance_to(initial_position) < 1:
			crash = false

func _on_input_event(viewport, event, shape_idx):
	# If not in a collision (get mouse/touch position)
	if not crash:
		var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
		if(!is_drag and event.is_pressed() and display.menu == display.MENU_LEVELING):
			selected = true
		if(!is_drag and !event.is_pressed()):
			selected = false

func _on_area_entered(area):
	# Ignore Paper Item
	if(area.name != "PaperIcon"):
		# If nozzle (hotend) touched Marker and not in collision
		if(area.name == "MarkerLevel" and not crash):
			# Get a Point
			levelingMeter.add_score()
			crash = true
			selected = false
		else:
			selected = false
			crash = true
			# Reset Score to Zero
			levelingMeter.reset_score()
		# Change Marker position
		levelingMeter.change_position()
		
