extends CharacterBody3D


const SPEED = 10.0

# Chargement de la scéne missile et du noeud boum
@export var missile : PackedScene
@export var boum_sound : AudioStreamPlayer

# Offsets pour les canons
var cannon_offset_left = Vector3(-0.8, 0, -0.1)
var cannon_offset_right = Vector3(0.8, 0, -0.1)

func _physics_process(_delta):

	#-----movement------

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	# ----gestion du tir------

	# get the shoot input
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	# Instanciez un missile pour chaque canon
	for offset in [cannon_offset_left, cannon_offset_right]:
		var missile_instance = missile.instantiate()
		# Positionnez le missile en fonction de l'offset du canon
		missile_instance.global_transform = global_transform.translated(offset)
		missile_instance.boum_sound = boum_sound
		# Ajoutez le missile à la scène (assurez-vous d'avoir une référence à la scène principale ou utilisez get_tree().current_scene)
		get_parent().add_child(missile_instance)
