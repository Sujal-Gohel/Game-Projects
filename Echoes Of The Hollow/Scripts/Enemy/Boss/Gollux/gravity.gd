extends States

@export var character: Boss

@onready var gravity : float = character.resource.gravity

func on_physics_process(delta : float):
	if !character.is_on_floor() :
		character.velocity.y += gravity * delta
	character.move_and_slide()
	if character.is_on_floor():
		transition.emit("idle")
