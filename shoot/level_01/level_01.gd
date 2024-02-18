extends Node3D

# Chemin vers la scène de l'ennemi
@export var enemy_scene : PackedScene

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var player = $player  # Obtenez une référence au nœud du joueur
	var player_position = player.global_transform.origin
	# Définir la position initiale de l'ennemi en face du joueur
	var spawn_position = Vector3(randi_range(-10, 10), 0, -20)
	# Ajouter l'ennemi à la scène
	add_child(enemy)
	#positionner l'enemy au bon endroit
	enemy.global_transform.origin = player_position + spawn_position





func _on_spawn_timeout():
	spawn_enemy()
