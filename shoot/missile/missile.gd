extends RigidBody3D
signal boum
var boum_sound : AudioStreamPlayer

func _on_area_3d_body_entered(body):
	if body.is_in_group("enemy"):
		emit_signal("boum")
		boum_sound.play()
		print("bobo")
		queue_free()


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
