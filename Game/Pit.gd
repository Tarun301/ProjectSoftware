extends Area2D



func _on_Pit_body_entered(body):
	Global.score = 0
	get_tree().reload_current_scene()
