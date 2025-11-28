extends States

@export var character : Player
@export var animated_body : AnimatedSprite2D
@onready var gravity : float = character.resources.gravity

var lerp_speed = 5

func on_process(_delta : float) :
	if animated_body.animation == "jump":
		await animated_body.animation_finished
	

func on_physics_process(delta : float):
	character.velocity.y += gravity * delta + (gravity/100 * 2)
	if character.velocity.y >= gravity:
		character.velocity.y = gravity
	var dir = GameInput.get_direction()
	if dir and !character.is_on_floor() :
		character.velocity.x = dir * character.resources.move_speed
		animated_body.flip_h = true if dir < 0 else false
	else :
		character.velocity.x = lerp(character.velocity.x , GameInput.get_direction() * character.resources.move_speed, lerp_speed * delta)
	character.move_and_slide()
	# idle
	if character.is_on_floor():
		character.SFX[1].play()
		transition.emit("idle")
	if GameInput.dash() and character.dash_cd:
		transition.emit("dash")
	#elif GameInput.attack():
		#transition.emit("attack")

func enter():
	animated_body.play("fall")

func exit():
	animated_body.stop()
