extends Control



func _on_restart_pressed():
	get_tree().reload_current_scene()

func set_score(value):
	$Panel/Score.text = "SCORE: " + str(value) 
	
func set_highest_score(value):
	$Panel/HighScore.text = "HI-SCORE: " + str(value) 
