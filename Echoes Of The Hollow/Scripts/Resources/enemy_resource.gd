class_name Enemy_Resource
extends Resource

@export var health : float
@export var damage : float
@export var slide_speed : float
@export var move_speed : float
@export var chase_speed : float
@export var attack_frame : int
@export var type : enemy_type
@export var gravity : float
@export var walk_range : float

enum enemy_type {
	WALK,
	FLY,
	JUMP
}
