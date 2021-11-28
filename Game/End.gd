extends KinematicBody2D

onready var player = get_node("../Player")

func _on_Area2D_body_entered(body):
	print("swag")
	get_tree().change_scene("res://Level 2.tscn")
