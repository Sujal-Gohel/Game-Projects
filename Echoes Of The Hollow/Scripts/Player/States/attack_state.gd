extends States

@export var character : Player
@export var animated_body : AnimatedSprite2D

#@onready var hitbox: Area2D = $"../../hitbox"
@onready var collision: CollisionShape2D = $"../../hitbox/CollisionShape2D"
#@onready var combo_timer: Timer = $"../../Timers/ComboTimer"
@onready var attack_frame : int = character.resources.Frames_attack1
@onready var damage = character.resources.damage
@onready var combo_cooldown: Timer = $"../../Timers/ComboCooldown"

var arr : Array
var attack_mode : int

var attacks : Dictionary = {
	1 : 
		["attack_1","attack_2","attack_3"],
	2 :
		["sword_1","sword_2","sword_3"]
}

#var attacks : Dictionary = {
	#1 : 
		#{"attack_1" : {2 : damage},"attack_2" : {2 : damage},"attack_3" : {1 : damage}},
	#2 :
		#{"sword_1" : {2 : damage},"sword_2" : {2 : damage},"sword_3" : {2 : damage}}
#}

var attack_ind : int = 0

func on_process(_delta : float):
	if animated_body.frame == attack_frame:
		collision.disabled = false
		await animated_body.frame_changed
		collision.disabled = true
	#if GameInput.attack():
		#await animated_body.animation_finished
		#change_attack()
	#elif !GameInput.attack():
	await animated_body.animation_finished
	transition.emit("idle")

func on_physics_process(_delta : float):
	pass

func enter():
	if attack_ind == 0:
		combo_cooldown.start()
	if character.resources.Has_Sword:
		attack_mode = 2
	else:
		attack_mode = 1
	animated_body.play(attacks[attack_mode][attack_ind])
	change_attack()
	#elif !character.is_on_floor():
		#animated_body.play("air_attack")

func exit():
	animated_body.stop()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		character.SFX[4].play()
		G_Signal.player_damage.emit(damage,character)

func change_attack():
	attack_ind += 1
	if attack_ind < attacks[attack_mode].size() :
		await animated_body.animation_finished
		animated_body.play(attacks[attack_mode][attack_ind])
	else:
		attack_ind = 0
	#print(attacks[attack_mode][attack_ind])
	


func _on_combo_timer_timeout() -> void:
	attack_ind = 0


func _on_combo_cooldown_timeout() -> void:
	attack_ind = 0
