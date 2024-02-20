extends Node3D

# Chemin vers la scène de l'ennemi
@export var enemy_scene : PackedScene
@export var boum_sound : AudioStreamPlayer
@export var Hud : Control


func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	# Obtenez une référence au nœud du joueur
	var player = $player
	# récupérer la position du joueur
	var player_position = player.global_transform.origin
	# Définir la position initiale de l'ennemi en face du joueur
	var spawn_position = Vector3(randi_range(-10, 10), 0, -20)
	# Ajouter l'ennemi à la scène
	enemy.boum_sound = boum_sound
	enemy.Hud = Hud
	add_child(enemy)
	#positionner l'enemy au bon endroit
	enemy.global_transform.origin = player_position + spawn_position


func _on_spawn_timeout():
	spawn_enemy()
