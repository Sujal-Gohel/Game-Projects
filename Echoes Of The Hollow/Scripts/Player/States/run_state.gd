extends States

@export var character : Player
@export var animated_body : AnimatedSprite2D
@onready var move_speed : int = character.resources.move_speed

var dir : float
var lerp_speed = 8

func on_process(_delta : float) :
	pass

func on_physics_process(delta : float):
	dir = GameInput.get_direction()
	if dir and character.is_on_floor():
		character.velocity.x = lerp(character.velocity.x , dir * move_speed, lerp_speed * delta)
		animated_body.flip_h = true if dir < 0 else false
	character.move_and_slide()
	
	if dir == 0 and character.is_on_floor():
		transition.emit("idle")
	if GameInput.jump():
		#if character.Cayote_Activate:
		transition.emit("jump")
	if GameInput.dash() and character.dash_cd:
		transition.emit("dash")
	if !character.is_on_floor():
		transition.emit("fall")

func enter():
	character.SFX[2].play()
	animated_body.play("run")

func exit():
	character.SFX[2].stop()
	animated_body.stop()
