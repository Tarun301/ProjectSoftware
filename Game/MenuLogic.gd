extends Node

func _on_Button_button_up():
	get_tree().change_scene("res://World.tscn")


func _on_Button2_button_up():
	Global.level = 1
	get_tree().change_scene("res://Level 2.tscn")


func _on_Button3_button_up():
	Global.level = 2
	get_tree().change_scene("res://Level 3.tscn")
