extends KinematicBody2D


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://Level 2.tscn")
