extends Area2D

@export var menu = 0
const MENU_DEFAULT = 0
const MENU_PRINT = 1
const MENU_FILAMENT = 2
const MENU_LEVELING = 3

var selected = false
var used = false
var light = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset():
	used = false
	light = true
	menu = 0
	$light.visible = true
	$light.energy = 0.5
	change_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not used:
		if light:
			$light.energy = $light.energy + 0.1
		else:
			$light.energy = $light.energy - 0.1
			
		if $light.energy <= 0.5:
			light = true
		if $light.energy >= 3:
			light = false
			
			

func _physics_process(_delta):
	pass
	
func change_menu():
	match menu:
		0:
			$Leveling.visible = false
			$Default.visible = true
		1:
			$Default.visible = false
			$Print.visible = true
		2:
			$Print.visible = false
			$Filament.visible = true
		3:
			$Filament.visible = false
			$Leveling.visible = true


func _on_input_event(_viewport, event, _shape_idx):
	var is_drag = event is InputEventScreenDrag or event is InputEventMouseMotion
	if(!is_drag and event.is_pressed()):
		selected = true

	if(!is_drag and !event.is_pressed() and selected == true):
		if not used:
			used = true
			$light.visible = false
		menu = menu + 1
		if menu == 4:
			menu = 0
		change_menu()
		selected = false

