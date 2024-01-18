extends Node2D

#déclacration des variables
var gamescore = 0
var score_text = "Brulure: " + str(gamescore)
var printer = 100
var printer_text = "impression en cours: " + str(printer) + "%"

func _ready():
	$score.text = score_text
	$printer.text = printer_text
	$printer.visible = false


func _on_character_body_2d_blark():
	gamescore += 1
	score_text = "Brulure: " + str(gamescore)
	$score.text = score_text


func _on_character_body_2d_printer():
	if printer > 0 and Input.is_action_pressed("use"):
		printer -= 1
		printer_text = "impression en cours: " + str(printer)
		$printer.visible = true
	elif printer == 0:
		printer_text = "impression en cours: DONE"
		if Input.is_action_pressed("take"):
			printer = 100
			$printer.visible = false
	$printer.text = printer_text
