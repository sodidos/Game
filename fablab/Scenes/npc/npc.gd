extends CharacterBody2D

@export var speed = 50
@export var min_idle = 3
@export var max_idle = 10
@export var machine: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var pathfinderTimer := $pathfinderTimer as Timer
@onready var idleTimer := $idleTimer as Timer
@onready var interactionTimer := $interactionTimer as Timer
@onready var Help := $Help as Sprite2D

var moving = true

var rand=RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(moving):
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed 
		move_and_slide()
	
func makepath() -> void:
	nav_agent.target_position = machine.global_position 

func _on_timer_timeout():
	makepath()

func _on_navigation_agent_2d_navigation_finished():
	moving = false
	pathfinderTimer.stop()
	var idletimer_rand = rand.randi_range(min_idle, max_idle)
	print(idletimer_rand)
	idleTimer.wait_time = idletimer_rand
	idleTimer.start()

func _on_idle_timer_timeout():
	print("Help needed")
	Help.visible = true


