extends Timer




func _on_Timer_timeout():
	get_tree().reload_current_scene()


func _on_ReadyTimer_timeout():
	self.start()
