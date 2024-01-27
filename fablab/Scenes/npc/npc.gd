extends CharacterBody2D

@export var speed = 50
@export var min_idle = 3
@export var max_idle = 10
@export var machine: Node2D
@export var sortie: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var pathfinderTimer := $pathfinderTimer as Timer
@onready var idleTimer := $idleTimer as Timer
@onready var interactionTimer := $interactionTimer as Timer
@onready var Help := $Help as Sprite2D
var destination: Node2D
var machine_in_use:Node2D

var moving = true
var goinghome = false

var rand=RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	print("New NPC")
	destination = machine
	print(destination)
	#for machine in machines.get_children():
	#	print(machine)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if(moving):
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed 
		move_and_slide()
	
func makepath() -> void:
	nav_agent.target_position = destination.global_position 

func _on_timer_timeout():
	makepath()

func _on_navigation_agent_2d_navigation_finished():
	if(goinghome):
		machine.inuse = false
		queue_free()
	else:
		moving = false
		pathfinderTimer.stop()
		var idletimer_rand = rand.randi_range(min_idle, max_idle)
		print(idletimer_rand)
		idleTimer.wait_time = idletimer_rand
		idleTimer.start()

func _on_idle_timer_timeout():
	print("Help needed")
	Help.visible = true
	idleTimer.stop()
	interactionTimer.start()

func _on_interaction_timer_timeout():
	print("Member pas content :-(")
	goinghome = true
	Help.visible = false
	interactionTimer.stop()
	destination = sortie
	pathfinderTimer.start()
	moving = true
