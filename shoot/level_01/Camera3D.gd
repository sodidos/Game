extends Camera3D

@export var spaceship: CharacterBody3D 
@export var camera: Camera3D

var smooth_speed = 2.0
var offset = Vector3(0, 10, 0)

func _process(delta):
	var target_position = spaceship.global_transform.origin + offset
	global_transform.origin = global_transform.origin.lerp(target_position, smooth_speed * delta)
	
	# Mettre à jour la position de la caméra manuellement si nécessaire
	camera.global_transform.origin = global_transform.origin
