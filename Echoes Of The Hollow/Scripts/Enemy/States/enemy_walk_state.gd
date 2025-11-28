extends States

@export var character : Enemy
@export var animated_body : AnimatedSprite2D

@onready var move_speed : float = character.resource.move_speed
@onready var fliped : bool = animated_body.flip_h
@onready var timer: Timer = $"../../Timer"

var dir : int = 1

func on_process(_delta : float):
	if character.left_detection.is_colliding() || character.right_detection.is_colliding():
		if character.left_detection.get_collider() == character.player || character.right_detection.get_collider() == character.player:
			transition.emit("chase")

func on_physics_process(_delta : float):
	character.velocity.x = dir * move_speed
	if (character.position.x <= character.right_point.position.x and character.position.x <= character.left_point.position.x):
		dir = 1
	elif (character.position.x >= character.left_point.position.x and character.position.x >= character.right_point.position.x):
		dir = -1
	#if !character.floor_detection_right.is_colliding() and character.floor_detection_left.is_colliding():
		#dir = 1
		#print("left")
	#elif !character.floor_detection_left.is_colliding() and character.floor_detection_right.is_colliding():
		#dir = -1
		#print("right")
	#elif character.wall_detection_right.is_colliding():
		#dir = 1 
	#elif character.wall_detection_left.is_colliding():
		#dir = -1
	if !fliped:
		animated_body.flip_h = true if dir < 0 else false
	if fliped:
		animated_body.flip_h = false if dir < 0 else true
	if character.position.x <= character.right_point.position.x and character.position.x >= character.left_point.position.x and timer.is_stopped():
		timer.start()
	character.move_and_slide()
	
func enter():
	animated_body.play("walk")

func exit():
	pass
