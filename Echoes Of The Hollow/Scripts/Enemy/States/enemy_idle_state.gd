extends States

@export var character : Enemy
@export var animated_body : AnimatedSprite2D

@onready var slide_speed : float = character.resource.slide_speed

func on_process(_delta : float):
	if character.left_detection.is_colliding() || character.right_detection.is_colliding():
		if character.left_detection.get_collider() == character.player || character.right_detection.get_collider() == character.player:
			transition.emit("chase")

func on_physics_process(delta : float):
	character.velocity.x = move_toward(character.velocity.x , 0 , slide_speed * delta)

func enter():
	animated_body.play("idle")

func exit():
	pass
