extends Area3D

var boum_sound : AudioStreamPlayer
@onready var Hud : Control


func _physics_process(delta):
	var translation = global_transform.origin + Vector3(0,0, 10 * delta)
	global_transform.origin = translation


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("missile"):
		Global.score += 1
		Hud.change()
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.vie -= 10
		Global.score += 1
		Hud.change()
		boum_sound.play()
		queue_free()
