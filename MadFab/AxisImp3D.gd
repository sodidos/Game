extends Area2D
var choc_buse = false
var choc_chassis = false

signal healthChanged
var currentHealth = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(not choc_buse):
		if(Input.is_action_pressed("ui_up")):
			position.y -= 0.5
		if(Input.is_action_pressed("ui_down")):
			position.y += 0.5
			#if (position.y > 305):
			#	print("BANG")
			#	choc_buse = true
	if(choc_buse):
		move_local_y(-5)
	if(choc_chassis):
		move_local_y(5)
	

func _on_area_entered(area):
	if area.is_in_group("CHASSIS"):
		choc_chassis = true
	if area.is_in_group("BED"):
		choc_buse = true
	healthChanged.emit()
	

	
func _on_area_exited(area):
	if area.is_in_group("CHASSIS"):
		choc_chassis = false
	if area.is_in_group("BED"):
		choc_buse = false
	currentHealth = currentHealth - 1
	print(currentHealth)


