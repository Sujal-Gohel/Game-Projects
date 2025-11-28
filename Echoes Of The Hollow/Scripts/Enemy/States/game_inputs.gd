extends States

@export var character : CharacterBody2D
@export var animated_body : AnimatedSprite2D

func on_process(delta : float) :
	pass

func on_physics_process(delta : float):
	pass

func enter():
	animated_body.play("damage")
	G_Signal.player_damage.connect(on_player_damage)

func exit():
	animated_body.stop()

func on_player_damage(player_damage):
	if character.hitbox.overlaps_body(character.player):
		character.health -= player_damage
		await animated_body.animation_finished
		print(character.health)
		if character.health <= 0:
			character.queue_free()
