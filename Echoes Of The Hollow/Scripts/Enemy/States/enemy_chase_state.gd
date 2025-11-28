extends States

@export var character : Enemy
@export var animated_body : AnimatedSprite2D

@onready var chase_speed : float = character.resource.chase_speed
@onready var fliped : bool = animated_body.flip_h

var chase_dir : int

func on_process(_delta : float) :
	if !character.left_detection.is_colliding() && !character.right_detection.is_colliding():
		transition.emit("walk")

func on_physics_process(_delta : float):
	if character.player:
		#var player_position_x = character.player.position.x
		if character.left_detection.is_colliding():# and (!character.floor_detection_right.is_colliding() or character.wall_detection_right.is_colliding()):
			chase_dir = -1
			character.velocity.x = chase_dir * chase_speed
		if character.right_detection.is_colliding():# and (!character.floor_detection_left.is_colliding() or character.wall_detection_left.is_colliding()):
			chase_dir = 1
			character.velocity.x = chase_dir * chase_speed
		else :
			chase_dir = 0
		if !fliped :
			animated_body.flip_h = false if chase_dir > 0 else true
		elif fliped :
			animated_body.flip_h = true if chase_dir > 0 else false
	if !character.player:
		transition.emit("idle")
	if character.AttackMode.overlaps_body(character.player):
		character.velocity.x = move_toward(character.velocity.x , 0 , 1)
		transition.emit("attack")
	character.move_and_slide()

func enter():
	animated_body.play("chase")

func exit():
	pass
