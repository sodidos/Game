extends RigidBody3D
var boum_sound : AudioStreamPlayer

func _on_area_3d_body_entered(body):
	if body.is_in_group("enemy"):
		boum_sound.play()
		queue_free()


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
