extends Node

@export var character: Enemy

@onready var gravity : float = character.resource.gravity

func _physics_process(delta: float) -> void:
	if !character.is_on_floor() :
		character.velocity.y += gravity * delta
	character.move_and_slide()
