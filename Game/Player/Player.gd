extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

export(int) var max_hp = 100
signal health_changed(health)

var ready = false

var velocity = Vector2.ZERO
var shooting = false
var direction = Vector2.RIGHT
var start = true
signal key1

onready var animationPlayer = $AnimationPlayer
onready var Arcane = preload ("res://Effects/Arcane.tscn")
onready var iFrames = $iFrames
onready var health = max_hp setget _set_health

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0 , max_hp)
	if health != prev_health:
		emit_signal("health_changed", health)
		if health == 0:
			Global.score = 0
			get_tree().reload_current_scene()

func damage(amount):
	if iFrames.is_stopped():
		iFrames.start()
		_set_health(health - amount)
		print(health)

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if Global.ready == true:
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
				if !$ArcaneSFX.is_playing():
					$ArcaneSFX.play()
				shoot()	
				shooting = true
			else:
				animationPlayer.play("shootLeft")
				if !$ArcaneSFX.is_playing():
					$ArcaneSFX.play()
				shoot()	
				shooting = true

func shoot():
	var a = Arcane.instance()
	add_child(a)
	a.global_position = self.global_position
	a.direction = direction

func notShooting():
	shooting = false
	
func _on_HP_body_entered(body):
	if start == true:
		health = 100
		start = false

func _on_Pit_body_entered(body):
	if body == self:
		Global.score = 0
		get_tree().reload_current_scene()

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		damage(25)
		$EnemyDeadSFX.play()


func _on_Key2_collected():
	$Collectable.play()
	Global.score = Global.score + 100
	emit_signal("key1")


func _on_Key_collected():
	Global.score = Global.score + 100
	$Collectable.play()
	emit_signal("key1")

func _on_Key3_collected():
	Global.score = Global.score + 100
	$Collectable.play()


func _on_ReadyTimer_timeout():
	Global.ready = true
