extends States

@export var character : Boss
@export var animated_body : AnimatedSprite2D

@onready var move_speed : float = character.resource.move_speed
@onready var attacks = ["attack_1","attack_2"]

var dir

func on_process(_delta : float):
	pass
	#if character.left_detection.is_colliding() || character.right_detection.is_colliding():
		#if character.left_detection.get_collider() == character.player || character.right_detection.get_collider() == character.player:
			#transition.emit("chase")

func on_physics_process(_delta : float):
	if character.player:
		if character.detection.overlaps_body(character.player):
			var player_position = character.player.position.x
			if player_position > character.position.x:
				dir = 1
				animated_body.flip_h = false
			if player_position < character.position.x:
				dir = -1
				animated_body.flip_h = true
			character.velocity.x = dir * move_speed
			#print(dir)
		character.move_and_slide()
	if !character.is_on_floor():
		transition.emit("fall")
	if character.resource.health <= 0:
		transition.emit("die")

func enter():
	if character.resource.health <= character.half_health:
		animated_body.speed_scale = 2
		move_speed = character.rage_speed
	animated_body.play("move")

func exit():
	pass


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if animated_body.animation == "attack_1" or animated_body.animation == "attack_2":
			await animated_body.animation_finished
		var random : String = attacks.pick_random()
		transition.emit(random)
