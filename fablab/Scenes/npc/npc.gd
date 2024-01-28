extends CharacterBody2D

var speed = 500
@export var min_idle = 3
@export var max_idle = 10

# Destinations
@export var machines: Node2D
@export var player: Node2D
@export var exit: Node2D
@export var ordis: Node2D

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var pathfinderTimer := $pathfinderTimer as Timer
@onready var idleTimer := $idleTimer as Timer
@onready var interactionTimer := $interactionTimer as Timer
@onready var Help := $Help as Sprite2D
@onready var sprite = $AnimatedSprite2D

@onready var dialogText := $dialog/dialogText
@onready var dialogTimer = $dialog/dialogTimer
var dialogState = 0

var destination: Node2D
var machine_in_use:Node2D

var fab_name = [
	"Truc1","Truc2","Truc3","Truc4"
]

var moving = true
var goinghome = false
var old_direction = Vector2()

var rand=RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	#destination = ordis.get_children()[0]
	destination = player
	nav_agent.target_position = destination.global_position 
	print("New NPC")
	print("Go to -->")
	print(destination)
	sprite.play("walk_down")

	#for machine in machines.get_children():
	#	print(machine)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if(moving):
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		var intended_velocity = dir * speed
		nav_agent.set_velocity(intended_velocity)
	else:
		if(destination == player):
			if(sprite.animation != "idle_down"):
				sprite.play("idle_down")
	#	if(!sprite.animation == "idle_up"):
	#		sprite.play("idle_up")

func makepath() -> void:
	print("Pathfinding...")
	nav_agent.target_position = destination.global_position 
	var direction = old_direction - nav_agent.get_next_path_position()
	print(nav_agent.distance_to_target())
	if(destination == player):
		if(nav_agent.distance_to_target() < 256):
			print("NEAR FABMANAGER")
			helloFabManager()
	if(abs(velocity.x) > abs(velocity.y)):
		if(velocity.x < 0):
			sprite.play("walk_left")
		else:
			sprite.play("walk_right")
	else:
		if(velocity.y < 0):
			sprite.play("walk_up")
		else:
			sprite.play("walk_down")
	old_direction = direction
	
func _on_timer_timeout():
	makepath()

func helloFabManager():
	pathfinderTimer.stop()
	moving = false
	print("Hello FabManager")
	sprite.play("idle_down")
	$dialog.visible = true
	dialogText.text = "Salut FabManager!"
	dialogTimer.start()
	
func _on_dialog_timer_timeout():
	if(dialogState == 0):
		var rand_fab = rand.randi_range(0,len(fab_name)-1)
		dialogText.text = "Je fabrique " + fab_name[rand_fab]
		dialogState = dialogState + 1
	elif(dialogState == 1):
		$dialog.visible = false
		dialogState = 0
		print("Destination")
		
		for ordi in ordis.get_children():
			if ordi.in_use == false:
				destination = ordi
				pathfinderTimer.start()
				moving = true
				print(ordi)
				break
		dialogTimer.stop()
				

func _on_navigation_agent_2d_navigation_finished():
	if(goinghome):
		#machine.inuse = false
		queue_free()
	else:
		print("Destination Reached")
		moving = false
		pathfinderTimer.stop()
		sprite.play("idle_up")
		if(destination.type == "ordi"):
			print("ordi")
			destination.in_use = true
			var idletimer_rand = rand.randi_range(min_idle, max_idle)
			print(idletimer_rand)
			idleTimer.wait_time = idletimer_rand
			idleTimer.start()
		elif(destination.type == "machine"):
			print("machine")
			destination.in_use = true
			var idletimer_rand = rand.randi_range(min_idle, max_idle)
			print(idletimer_rand)
			idleTimer.wait_time = idletimer_rand
			idleTimer.start()
		
		#

func _on_idle_timer_timeout():
	if(destination.type == "ordi"):
		destination.in_use = false
		for machine in machines.get_children():
			if machine.in_use == false:
				destination = machine
				pathfinderTimer.start()
				moving = true
				idleTimer.stop()
	elif(destination.type == "machine"):
		destination.in_use = false
		idleTimer.stop()
		destination = exit
#	Help.visible = true
#	idleTimer.stop()
#	interactionTimer.start()

#func _on_interaction_timer_timeout():
#	goinghome = true
#	Help.visible = false
#	interactionTimer.stop()
#	destination = exit
#	pathfinderTimer.start()
#	moving = true

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	if(moving):
		velocity = safe_velocity
		move_and_slide() # Replace with function body.


