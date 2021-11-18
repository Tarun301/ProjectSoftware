extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO
var shooting = false
var direction = Vector2.RIGHT

onready var animationPlayer = $AnimationPlayer
onready var Arcane = preload ("res://Effects/Arcane.tscn")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			if shooting == false:
				direction = Vector2.RIGHT
				animationPlayer.play("RunRight")
		else:
			if shooting == false:
				direction = Vector2.LEFT
				animationPlayer.play("RunLeft")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		if shooting == false:
			animationPlayer.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)

func _input(event):
	if event.is_action_pressed("shoot"):
		if shooting == false:
			if direction == Vector2.RIGHT:
				animationPlayer.play("shoot1")
				shoot()	
				shooting = true
			else:
				animationPlayer.play("shootLeft")
				shoot()	
				shooting = true

func shoot():
	var a = Arcane.instance()
	add_child(a)
	a.global_position = self.global_position
	a.direction = direction

func notShooting():
	shooting = false
