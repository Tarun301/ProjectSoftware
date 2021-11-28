extends Area2D

var direction = Vector2.RIGHT
var speed = 200 # pixels / s

signal enemyDead()
func _ready():
    set_as_toplevel(true) # move independent from parent node

func _physics_process(delta):
	global_position += direction * speed * delta
	

func _on_Arcane_body_entered(body):
	if body.is_in_group("enemy"):
		emit_signal("enemyDead")
		queue_free()
		body.queue_free()

