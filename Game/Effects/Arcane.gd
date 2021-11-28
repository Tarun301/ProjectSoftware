extends Area2D

var direction = Vector2.RIGHT
var speed = 200 # pixels / s

signal enemy_dead

func _physics_process(delta):
	global_position += direction * speed * delta
	

func _on_Arcane_body_entered(body):
	if body.is_in_group("enemy"):
		emit_signal("enemy_dead")
		Global.score = (Global.score + 25)
		queue_free()
		body.queue_free()

