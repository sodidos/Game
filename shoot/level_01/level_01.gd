extends Node3D

# Chemin vers la scène de l'ennemi
@export var enemy_scene : PackedScene

# Paramètres de génération
var spawn_rate = 1.0 # Ennemis par seconde
var spawn_timer = 0.0

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= 1.0 / spawn_rate:
		spawn_enemy()
		spawn_timer = 0

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

func _on_boum():
	print("boum")
	$boom.play()
