extends States

@export var character : Player
@export var animated_body : AnimatedSprite2D

@onready var dash_speed = character.resources.dash_speed
@onready var dash_time = character.resources.dash_time

var dir
var lerp_speed = 25

func on_process(_delta : float):
	await get_tree().create_timer(dash_time).timeout
	character.dash_cooldown.start()
	if GameInput.get_direction():
		transition.emit("run")
	if GameInput.jump():
		transition.emit("jump")
	if GameInput.attack():
		transition.emit("attack")
	else:
		transition.emit("idle")
	pass

func on_physics_process(delta : float):
	dir = 1 if !animated_body.flip_h else -1
	character.velocity.x = lerp(character.velocity.x , dir * dash_speed, lerp_speed * delta)
	character.move_and_slide()

func enter():
	character.SFX[3].play()
	character.dash_cd = false
	animated_body.play("dash")

func exit():
	animated_body.stop()
