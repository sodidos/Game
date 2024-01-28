extends Node

@export var newNPC: PackedScene
@export var minTimeSpawn = 5
@export var maxTimeSpawn = 10 
@export var SpawnerBlockTime = 1.0
@export var machines: Node2D
@export var exit: Node2D
@export var player: CharacterBody2D
@export var onlyOneNPC = false
@onready var npcSpawnerTimer := $npcSpawnerTimer as Timer

var wait_for_space = false
#@export var npc: CharacterBody2D
var rand=RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	newSpawnWait()


func newSpawnWait():
	var newNpcTime = rand.randf_range(minTimeSpawn, maxTimeSpawn)
	npcSpawnerTimer.wait_time = newNpcTime
	npcSpawnerTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_npc_spawner_timer_timeout():
	print("Spawn New")
	#var random_machine = randi_range(0, len(machines.get_children()) - 1)
	#var machine = machines.get_children()[random_machine]
	#if(not machine.inuse):
	var n = newNPC.instantiate()	
	#	machine.inuse = true
	#	n.machine = machine
	#	n.sortie = sortie
	n.player = player
	n.exit = exit
	n.machines = machines
	add_child(n)
	print("Spawn Blocked")
	if(!onlyOneNPC):
		npcSpawnerTimer.stop()

func _on_npc_spawner_block_timer_timeout():
	print("Spawn enable")
	newSpawnWait()

