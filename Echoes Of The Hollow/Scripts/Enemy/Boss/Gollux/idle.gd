extends States

@export var character : Boss
@export var animated_body : AnimatedSprite2D

@onready var slide_speed : float = character.resource.slide_speed
@onready var attacks = ["attack_1","attack_2"]

func on_process(_delta : float):
	pass
	#if character.left_detection.is_colliding() || character.right_detection.is_colliding():
		#if character.left_detection.get_collider() == character.player || character.right_detection.get_collider() == character.player:
			#transition.emit("chase")

func on_physics_process(delta : float):
	character.velocity.x = move_toward(character.velocity.x , 0 , slide_speed * delta)
	character.move_and_slide()
	if !character.is_on_floor():
		transition.emit("fall")

func enter():
	if character.resource.health <= character.half_health:
		animated_body.speed_scale = 2
	animated_body.play("idle")

func exit():
	pass

func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		transition.emit("move")
	if character.resource.health <= 0:
		transition.emit("die")

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if animated_body.animation == "attack_1" or animated_body.animation == "attack_2":
			await animated_body.animation_finished
		var random : String = attacks.pick_random()
		transition.emit(random)


func _on_attack_cooldown_timeout() -> void:
	var random : String = attacks.pick_random()
	transition.emit(random)
