extends Node

@export var newNPC: PackedScene
@export var minTimeSpawn = 5
@export var maxTimeSpawn = 10 
@export var machines: Node2D
@export var sortie: Node2D
@export var onlyOneNPC = false
@onready var npcSpawnerTimer := $npcSpawnerTimer as Timer
#@export var npc: CharacterBody2D
var rand=RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var newNpcTime = rand.randf_range(0, 1)
	npcSpawnerTimer.wait_time = newNpcTime
	npcSpawnerTimer.start()
	print("Add NPC")
	print(newNpcTime)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_npc_spawner_timer_timeout():
	var free_machine = false
	var random_machine = randi_range(0, len(machines.get_children()) - 1)
	var machine = machines.get_children()[random_machine]
	if(not machine.inuse):
		print("Add NPC DONE")
		var n = newNPC.instantiate()	
		machine.inuse = true
		n.machine = machine
		n.sortie = sortie
		add_child(n)
		if(onlyOneNPC):
			npcSpawnerTimer.stop()
	else:
		print("Machine not free :-()")
