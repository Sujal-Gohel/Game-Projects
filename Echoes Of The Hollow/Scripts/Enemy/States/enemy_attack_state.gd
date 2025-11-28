extends States

@export var character : Enemy
@export var animated_body : AnimatedSprite2D

func on_process(_delta : float) :
	pass

func on_physics_process(_delta : float):
	if animated_body.frame == character.resource.attack_frame and character.hit_box.overlaps_body(character.player):
		print(character.hit_box.overlaps_body(character.player))
		G_Signal.enemy_damage.emit(character.resource.damage,character)
	#await animated_body.animation_finished
	if character.player :
		if character.AttackMode.overlaps_body(character.player):
			await animated_body.animation_finished
			enter()

func enter():
	var player_position = character.player.position.x
	if player_position > character.position.x:
		animated_body.flip_h = false
	if player_position < character.position.x:
		animated_body.flip_h = true
	animated_body.play("attack")

func exit():
	animated_body.stop()
