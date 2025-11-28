class_name BossResource
extends Resource

@export var health : float
@export var damage : float
@export var slide_speed : float
@export var move_speed : float
@export var attack_frame : Array[int]
@export var type : boss_type
@export var gravity : float
@export var is_dead : bool = false

enum boss_type {
	WALK
}
