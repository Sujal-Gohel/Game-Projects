extends States

@export var character : Player
@export var animated_body : AnimatedSprite2D

@onready var slide : int = character.resources.slide_speed

func on_process(_delta : float) :
	pass

func on_physics_process(delta : float):
	if character.velocity.x != 0:
		character.velocity.x = move_toward(character.velocity.x , 0 , slide * delta)
	character.move_and_slide()
	# fall
	if !character.is_on_floor():
		transition.emit("fall")
	if GameInput.get_direction():
		transition.emit("run")
	if GameInput.jump():
		transition.emit("jump")
	if GameInput.attack():
		transition.emit("attack")
	if GameInput.dash() and character.dash_cd:
		transition.emit("dash")

func enter():
	animated_body.play("idle")

func exit():
	animated_body.stop()
