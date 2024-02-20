extends Area3D
var boum_sound : AudioStreamPlayer

func _physics_process(delta):
	var translation = global_transform.origin + Vector3(0,0, -20 * delta)
	global_transform.origin = translation


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("enemy"):
		boum_sound.play()
		queue_free()
