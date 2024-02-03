extends ProgressBar

@export var printer3D: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	printer3D.healthChanged.connect(update)
	update()

func update():
	value = printer3D.currentHealth
	print("Update LifeBar")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


