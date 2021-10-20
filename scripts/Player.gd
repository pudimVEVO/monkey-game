extends KinematicBody2D

const TYPE = 'player'

signal health_changed(health, max_health)
signal death

export var fall_gravity_scale := 60.0
export var low_jump_gravity_scale := 40.0
export var jump_power := 350
export (float) var speed = 125
export (float, 0, 1.0) var friction = 0.25
export (float, 0, 1.0) var acceleration = 0.25
var jump_released = false

onready var sprite = $Sprite
onready var animationplayer = $AnimationPlayer

var max_health = 5
var health = max_health
var velocity = Vector2()
var earth_gravity = 9.807
export var gravity_scale := 100.0
var on_floor = false

func get_input():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	
	var dir = 0
	
	if right:
		dir += 1
		sprite.flip_h = dir < 0
	if left:
		dir -= 1
		sprite.flip_h = dir < 0
	if dir != 0:
		if is_on_floor():
			animationplayer.play("walk")
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if is_on_floor():
			animationplayer.play("idle")
	
	


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_released("ui_up"):
		jump_released = true
		animationplayer.play("fall")
	
	velocity += Vector2.DOWN * earth_gravity * gravity_scale * delta
	
	if velocity.y > 0:
		velocity += Vector2.DOWN * earth_gravity * fall_gravity_scale * delta
	elif velocity.y < 0 && jump_released:
		velocity += Vector2.DOWN * earth_gravity * low_jump_gravity_scale * delta
	
	if on_floor:
		if Input.is_action_just_pressed("ui_up"):
			animationplayer.play("Jump")
			velocity = Vector2.UP * jump_power
			jump_released = false
		
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		on_floor = true
	else:
		on_floor = false
	
	get_input()
	

#func damage():
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		if collision.collider.is_in_group("hazard"):
#			die()
#

func collision():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.is_in_group("hazard") :
			print("AH")



func die():
	if health <= 0:
		pass
	emit_signal("death")

func damage():
	health -= 1
	emit_signal("health_changed", health, max_health)
	if health <= 0:
		die()
	#MAKE KNOCKBACK SHIT

#func knockback():
#	#knockback???




























































#extends KinematicBody2D
#
#signal player_died
#signal health_changed(health, max_health)
#
#const TARGET_FPS = 60
#const ACCELERATION = 22
#const MAX_SPEED = 200
#const FRICTION = 10
#const AIR_RESISTANCE = 1.5
#const GRAVITY = 20
#const JUMP_FORCE = 530
#
#var max_health = 5
#var health = max_health
#var current_direction = "right"
#var motion = Vector2.ZERO
#
#onready var sprite = $Sprite
#onready var animationPlayer = $AnimationPlayer
#
#func set_current_direction(direction):
#	if direction == "right":
#		current_direction = "right"
#	else:
#		current_direction = "left"
#
#func _physics_process(delta):
#	movement(delta)
#
#
#func movement(delta):
#	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#
#	if x_input != 0 && is_on_floor():           #move
#		animationPlayer.play("walk")
#		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
#		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
#		sprite.flip_h = x_input < 0
#
#	if x_input != 0 && x_input != 0:
#		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
#		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
#		sprite.flip_h = x_input < 0
#		set_current_direction("left")
#
#	if is_on_floor() && x_input == 0:
#		animationPlayer.play("idle")
#
#	motion.y += GRAVITY * delta * TARGET_FPS
#
#	if is_on_floor():
#		if x_input == 0:
#			motion.x = lerp(motion.x, 0, FRICTION * delta)
#
#		if Input.is_action_just_pressed("ui_up"):
#			var posn = motion.y
#			motion.y = -JUMP_FORCE
#
#	else:
#
#		animationPlayer.play("Jump")
#
#
#		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
#			motion.y = -JUMP_FORCE/2
#
#
#		if x_input == 0:
#			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
#
#
#
#
#
#	motion = move_and_slide(motion, Vector2.UP)
#
#func damage():
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		if collision.collider.is_in_group("hazard"):
#			die()
#
#	health -= 1
#	emit_signal("health_changed", health, max_health)
#	if health <= 0:
#		die()
#
#
#
#func die():
#	queue_free()
#	emit_signal("player_died")
