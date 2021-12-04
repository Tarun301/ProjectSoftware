extends KinematicBody2D

onready var player = get_node("../../Player")
onready var winText = get_node("../CanvasLayer/Ready2/Label")
onready var timer = get_node("../CanvasLayer/Timer/Timer")
func _on_Area2D_body_entered(body):
	Global.level = Global.level + 1
	if Global.level == 1:
		Global.ready = false
		get_tree().change_scene("res://Level 2.tscn")
	if Global.level == 2:
		Global.ready = false
		get_tree().change_scene("res://Level 3.tscn")
	if Global.level == 3:
		timer.stop()
		winText.text = "You win!"
