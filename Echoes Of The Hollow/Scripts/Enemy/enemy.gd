class_name Enemy
extends CharacterBody2D

@onready var AttackMode: Area2D = $AttackMode
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#@onready var animated_body: AnimatedSprite2D = $AnimatedSprite2D
@onready var left_detection: RayCast2D = $PlayerDetection/LeftDetection
@onready var right_detection: RayCast2D = $PlayerDetection/RightDetection
@onready var left_point : Marker2D = $Limits/LeftPoint
@onready var right_point : Marker2D = $Limits/RightPoint
@onready var player := get_tree().get_first_node_in_group("player") as Player
@onready var wall_detection_right: RayCast2D = $PlayerDetection/WallDetectionRight
@onready var wall_detection_left: RayCast2D = $PlayerDetection/WallDetectionLeft
@onready var floor_detection_right: RayCast2D = $PlayerDetection/FloorDetectionRight
@onready var floor_detection_left: RayCast2D = $PlayerDetection/FloorDetectionLeft
#@onready var collision_shape_2d: CollisionShape2D = $HitBox/CollisionShape2D
@onready var hit_box: Area2D = $HitBox
@onready var hit_collision: CollisionShape2D = $HitBox/HitCollision

@export var resource : Enemy_Resource

var kill_count : int = 0

func _ready() -> void:
	left_point.position.x = position.x + resource.walk_range
	right_point.position.x = position.x - resource.walk_range

func _process(_delta: float) -> void:
	if animated_sprite_2d.flip_h:
		hit_collision.position.x = -25
	else:
		hit_collision.position.x = 25
	

func _physics_process(_delta: float) -> void:
	#print(character.animation)
	if player.hurtbox.overlaps_body(self):
		G_Signal.enemy_damage.emit(2,self)
	pass
