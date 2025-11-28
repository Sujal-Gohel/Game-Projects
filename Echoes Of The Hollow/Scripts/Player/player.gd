class_name Player extends CharacterBody2D

signal gameover

@onready var spawn_point: Marker2D = $"../SpawnPoint"
@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var Hit_Collision: CollisionShape2D = $hitbox/CollisionShape2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var state_machine: StateMachine = $StateMachine
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var health_bar_ui: TextureProgressBar = $CanvasLayer/PlayerUI/PanelContainer/HealthBarUI
@onready var dash_cooldown: Timer = $Timers/DashCooldown
@onready var hurtbox: Area2D = $Hurtbox
@onready var damage_cooldown: Timer = $Timers/DamageCooldown
#@onready var shader_material : ShaderMaterial = preload("uid://b5b51lww0go2")
@onready var hurt_collision: CollisionShape2D = $Hurtbox/HurtCollision

@export var resources : Player_Resource
@export var health : float
@export var SFX : Array[AudioStreamPlayer]
#@export var player_hp : float = 100
#@export var damage : float = 5
#@export var slide : int = 3000
#@export var gravity : float = 1000
#@export var move_speed : int = 500
#@export var jump_force : float = 400
#@export var attack_frame : int

var spawn_pos : Vector2
var level : String
var tween : Tween
var can_dash : bool = false
var dash_cd : bool = false

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	print("Player : ",resources.Power_Dash)
	resources.health = health
	if resources.Power_Dash and !can_dash:
		can_dash = true
	if can_dash:
		dash_cd = true
	if health_bar_ui:
		health_bar_ui.call_deferred("init_health",health)
	G_Signal.enemy_damage.connect(do_damage)
	SceneChange.SceneChange.connect(on_scene_change)
	QuestManager.receive.connect(claim_reward)

func _process(_delta: float) -> void:
	if animated_sprite_2d.flip_h:
		Hit_Collision.position.x = -32
	else : 
		Hit_Collision.position.x = 32

func _physics_process(_delta: float) -> void:
	pass

func do_damage(enemy_damage,enemy):
	if G_Signal.enemy_damage.is_connected(do_damage):
		G_Signal.enemy_damage.disconnect(do_damage)
	if state_machine.get_parent() == self and collision.get_parent() == self and animation_player.get_parent() == self:
		if !hurt_collision.disabled:
			hurt_collision.set_deferred("disabled",true)
			damage_cooldown.start()
			resources.health -= enemy_damage
			health_bar_ui.health = resources.health
			SFX[5].play()
			animation_player.play("player_hurt")
			await animation_player.animation_finished
			#HIT EFFECT-FRAME FREEZE AND KNOCKBACK
			Effects.KnockBack(enemy,self)
			Effects.FrameFreeze(0.1,0.5)
			animation_player.play("DamageCD")
			if resources.health <= 0 :
				die()
	if !G_Signal.enemy_damage.is_connected(do_damage):
		G_Signal.enemy_damage.connect(do_damage)

func die():
	animation_player.stop()
	if state_machine.get_parent() == self and collision.get_parent() == self and animation_player.get_parent() == self:
		remove_child(state_machine)
		remove_child(collision)
		remove_child(animation_player)
		spawn_pos = spawn_point.global_position
		animated_sprite_2d.play("die")
		await animated_sprite_2d.animation_finished
		gameover.emit()

func on_scene_change(_main,_new_level):
	if SceneChange.Activate :
		spawn_pos = SceneChange.PlayerPos
		global_position = spawn_pos
		if SceneChange.PlayerJumponEnter:
			velocity.y = -resources.max_jump_height
		SceneChange.Activate = false
		global_position.normalized()
	#LoadScreen.play("fade_out")

func reset_health():
	resources.health = health
	health_bar_ui.health = resources.health

func _on_dash_cooldown_timeout() -> void:
	dash_cd = true
	pass


func _on_hurtbox_body_entered(body: Node2D) -> void:
	#if hurtbox.overlaps_body(body):
	if body.is_in_group("Boss") or body.is_in_group("Enemy"):
		do_damage(2,body)

func claim_reward(reward_type : String, reward : String):
	match reward_type:
		"ITEM":
			pass
		"POWER":
			match reward:
				"DASH":
					resources.Power_Dash = true
					can_dash = true
					dash_cd = true
					SaveLoad.game_save()
				"SWORD":
					resources.Has_Sword = true
					print("AT Player Reward",resources.Has_Sword)
					SaveLoad.game_save()


func _on_damage_cooldown_timeout() -> void:
	if animation_player.current_animation == "DamageCD":
		if animation_player.is_playing():
			animation_player.stop()
	hurt_collision.set_deferred("disabled",false)
