class_name GameInput
extends Node

static func get_direction() -> float :
	var dir = Input.get_axis("left","right")
	return dir

static func jump() -> bool:
	var jumped = Input.is_action_just_pressed("jump")
	return jumped

static func jumping() -> bool:
	var is_jumping = Input.is_action_pressed("jump")
	return is_jumping

static func jump_released() -> bool:
	var released = Input.is_action_just_released("jump")
	return released

static func attack() -> bool:
	var attacked = Input.is_action_just_pressed("attack")
	return attacked

static func interact() -> bool:
	var interacted = Input.is_action_just_pressed("Interact")
	return interacted

static func dash() -> bool:
	var dashing = Input.is_action_just_pressed("dash")
	return dashing
