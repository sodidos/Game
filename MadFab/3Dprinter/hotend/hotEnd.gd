extends Area2D

@export var printer: Node2D
@export var attachedObject: Area2D
@export var crash_speed = 25
@export var move_speed = 50

# Save original position
var initial_position
# Offset Mouse to make it more visible on mobile
var offset = Vector2(0,40)
# Is HotEnd Drag
var selected = false
# Is HotEnd has been in a collision
var crash = false

func reset():
	global_position = initial_position
	crash = false
	selected = false
	printer.levelingMeter.reset_score()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Backup position before moving
	initial_position = global_position
	attachedObject.global_position.y = global_position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	if selected and not crash:
		# Follow Mouse
		global_position = lerp(global_position, get_global_mouse_position() + offset, printer.move_speed * delta)
		# Axis follow HotEnd (y only)
		attachedObject.global_position.y = global_position.y
	if crash:
		# Go Back to original Position
		global_position = lerp(global_position, initial_position, printer.return_to_origin_speed * delta)
		attachedObject.global_position.y = global_position.y
		# Orignal position reached
		if global_position.distance_to(initial_position) < 1:
			crash = false

func _on_input_event(_viewport, event, _shape_idx):
	# If not in a collision (get mouse/touch position)
	if not crash:
		var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
		if(!is_drag and event.is_pressed() and printer.display.menu == printer.display.MENU_LEVELING):
			selected = true
		if(!is_drag and !event.is_pressed()):
			selected = false

func _on_area_entered(area):
	# Ignore Paper Item
	if(area.name != "paper" and area.name != "PaperIcon" and area.name != "FilamentIcon"):
		# If nozzle (hotend) touched Marker and not in collision
		if(area.name == "MarkerLevel" and printer.paperIcon.placed and not crash):
			# Get a Point
			printer.levelingMeter.add_score()
			crash = true
			selected = false
			printer.levelingMeter.change_position()
		else:
			selected = false
			crash = true
			# Reset Score to Zero
			printer.levelingMeter.reset_score()
		# Change Marker position
		
		
