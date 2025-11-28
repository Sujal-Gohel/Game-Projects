extends Area2D

@onready var player := get_tree().get_first_node_in_group("player") as Player
@onready var ui: Control = $UI
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var LevelPath : String
@export var SpawnPoint : Vector2

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _process(_delta: float) -> void:
	if overlaps_body(player):
		if GameInput.interact():
			#print("saved")
			player.spawn_point.global_position = SpawnPoint
			player.level = LevelPath
			#player.spawn_point = SpawnPoint
			SaveLoad.game_save()
			player.reset_health()

#func _on_body_entered(body: Node2D) -> void:
	#if body is Player:
		#if overlaps_body(body):
			#if GameInput.interact():
				#print("saved")
				#body.spawn_pos = SpawnPoint
				#body.level = LevelPath
				#SaveLoad.game_save()
		#


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		ui.visible = true
		animation_player.play("FadeIn")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation_player.play_backwards("FadeIn")
		await animation_player.animation_finished
		ui.visible = false
