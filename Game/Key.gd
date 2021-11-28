extends KinematicBody2D

onready var player = get_node("../Player")

signal collected

func _on_Area2D_body_entered(body):
	if body == player:
		emit_signal ("collected")
		queue_free()
