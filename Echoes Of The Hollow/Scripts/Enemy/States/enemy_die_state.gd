extends Node

@export var character : Enemy
@export var animated_body : AnimatedSprite2D

@onready var hitbox: Area2D = $"../AttackMode"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var state_control: StateMachine = $"../StateControl"
@onready var health : float = character.resource.health

func _ready() -> void:
	pass
	G_Signal.player_damage.connect(on_player_damage)

func _process(_delta : float) :
	pass

func _physics_process(_delta : float):
	if health <= 0:
		if QuestManager.quest_status == QuestManager.Status.PROGESSING:
			QuestManager.killed.emit(1)
		for child in character.get_children():
			if child == animated_body:
				continue
			character.remove_child(child)
		animated_body.play("die")
		await animated_body.animation_finished
		character.queue_free()

func on_player_damage(player_damage,dealer):
	if G_Signal.player_damage.is_connected(on_player_damage):
		G_Signal.player_damage.disconnect(on_player_damage)
	if character:
		if hitbox.overlaps_body(character.player):
			animation_player.play("hurt")
			Effects.FrameFreeze(0.1,0.2)
			Effects.KnockBack(dealer,character)
			health -= player_damage
	if !G_Signal.player_damage.is_connected(on_player_damage):
		G_Signal.player_damage.connect(on_player_damage)
