extends Area2D

@export var menu = 0
const MENU_DEFAULT = 0
const MENU_PRINT = 1
const MENU_FILAMENT = 2
const MENU_LEVELING = 3

var selected = 0
var used = false
var light = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not used:
		if light:
			$light.energy = $light.energy + 0.1
		else:
			$light.energy = $light.energy - 0.1
			
		if $light.energy <= 0.5:
			light = true
		if $light.energy >= 3:
			light = false
			
			

func _physics_process(delta):
	pass
		
func _on_input_event(viewport, event, shape_idx):
	var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
	if(!is_drag and event.is_pressed()):
		selected = true
	if(!is_drag and !event.is_pressed() and selected == true):
		print("Pressed")
		if not used:
			used = true
			$light.visible = false
		menu = menu + 1
		if menu == 4:
			menu = 0
		match menu:
			0:
				$Leveling.visible = false
				$Default.visible = true
				print("Return to Main")
			1:
				$Default.visible = false
				$Print.visible = true
				print("Print Menu")
			2:
				$Print.visible = false
				$Filament.visible = true
				print("Filament Menu")
			3:
				$Filament.visible = false
				$Leveling.visible = true
				print("Leveling Menu")
		selected = false
	


func _on_button_area_input_event(viewport, event, shape_idx):
	print("Button pressed")
