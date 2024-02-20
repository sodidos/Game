extends Control


func change():
	var vie = Global.vie
	var score = Global.score
	$VieLabel.text = str("vie : ", vie)
	$ScoreLabel.text = str("score : ", score)
