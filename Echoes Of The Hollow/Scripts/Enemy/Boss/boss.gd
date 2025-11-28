class_name Boss
extends CharacterBody2D

signal died

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var detection: Area2D = $Detection
@onready var player := get_tree().get_first_node_in_group("player") as Player
@onready var player_detection: Area2D = $PlayerDetection
@onready var health_bar: TextureProgressBar = $CanvasLayer/HealthBar
@onready var hitbox: Area2D = $Hitbox

@export var resource : BossResource
@export var level_path : String

var half_health : float
var rage_damage : float
var rage_speed : float
var health : float = 100

func _ready() -> void:
	if player.resources.Boss_Gollux:
		resource.is_dead = true
	if resource.is_dead:
		queue_free()
	resource.health = health
	half_health = resource.health / 2
	rage_damage = resource.damage * 1.75
	rage_speed = resource.move_speed * 3
	#print(player.resources.Boss_Gollux)
	G_Signal.player_damage.connect(on_player_damage)
	health_bar.call_deferred("init_health",resource.health)

func _physics_process(_delta: float) -> void:
	#print(resource.health)
	pass

func on_player_damage(player_damage,dealer):
	resource.health -= player_damage
	health_bar.health = resource.health
	animation_player.play("hurt")
	Effects.FrameFreeze(0.1,0.3)
	Effects.KnockBack(dealer,self)
	#print(resource.health)

func rage():
	animated_sprite_2d.speed_scale = 2
	resource.damage = rage_damage
	resource.move_speed = rage_speed
