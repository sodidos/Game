extends CharacterBody2D

signal blark
signal printer

@export var speed = 200
@onready var _animated_sprite = $AnimatedSprite2D
var idle="idle_right"


func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("walk_right")
		idle="idle_right"
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.play("walk_left")
		idle="idle_left"
	elif Input.is_action_pressed("ui_up"):
		_animated_sprite.play("walk_up")
		idle="idle_up"
	elif Input.is_action_pressed("ui_down"):
		_animated_sprite.play("walk_down")
		idle="idle_down"
	else:
		_animated_sprite.play(idle)
	move_and_slide()


func _on_timer_timeout():
	$Area2D.set_deferred("monitoring",true)


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		blark.emit()
		$Area2D.set_deferred("monitoring",false)
		$blarkTimer.start()
	elif body.is_in_group("printer"):
		printer.emit()
		$Area2D.set_deferred("monitoring",false)
		$printerTimer.start()


func _on_printer_timer_timeout():
	$Area2D.set_deferred("monitoring",true)
