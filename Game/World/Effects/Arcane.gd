extends Area2D

var direction = Vector2.RIGHT
var speed = 100 # pixels / s

func _ready():
    set_as_toplevel(true) # move independent from parent node

func _physics_process(delta):
    global_position += direction * speed * delta
