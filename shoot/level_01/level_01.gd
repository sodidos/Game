extends Node3D

# Chemin vers la scène de l'ennemi
@export var enemy_scene : PackedScene

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var player = $player  # Obtenez une référence au nœud du joueur
	var player_position = player.global_transform.origin
	# Définir la position initiale de l'ennemi
	# Par exemple, en face du joueur mais à une distance et hauteur aléatoires
	var spawn_position = Vector3(randi_range(-10, 10), 0, -20) # Ajustez selon votre scène
	enemy.global_transform.origin = player_position + spawn_position
	# Ajouter l'ennemi à la scène
	# get_tree().root.
	add_child(enemy)


func _on_spawn_timeout():
	spawn_enemy()
