extends States

@export var character : Player
@export var animated_body : AnimatedSprite2D

@onready var max_jump_height : float = -character.resources.max_jump_height
@onready var jump_force : float = -character.resources.jump_force

var lerp_speed = 5

func on_process(_delta : float) :
	await animated_body.animation_finished

func on_physics_process(delta : float):
	if character.velocity.y > max_jump_height and GameInput.jumping() :
		character.velocity.y += jump_force * 0.15
	#if character.velocity.y <= max_jump_height:
		#character.velocity.y = max_jump_height
	
	var dir = GameInput.get_direction()
	if dir and !character.is_on_floor() :
		character.velocity.x = dir * character.resources.move_speed
		animated_body.flip_h = true if dir < 0 else false
	else :
		character.velocity.x = lerp(character.velocity.x , GameInput.get_direction() * character.resources.move_speed, lerp_speed * delta)
	
	character.move_and_slide()
	if character.is_on_floor():
		transition.emit("idle")
	if GameInput.jump_released() or (character.velocity.y <= max_jump_height and !character.is_on_floor()):
		transition.emit("fall")
	elif character.velocity.y == 0 or character.velocity.y == jump_force:
		transition.emit("fall")
	if GameInput.dash() and character.dash_cd:
		transition.emit("dash")
	#elif GameInput.attack():
		#transition.emit("attack")

func enter():
	character.SFX[0].play()
	jump_force = -character.resources.jump_force
	character.velocity.y = jump_force
	animated_body.play("jump")

func exit():
	await animated_body.animation_finished
	animated_body.stop()
