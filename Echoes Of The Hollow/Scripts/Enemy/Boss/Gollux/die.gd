extends States

@export var character : Boss
@export var animated_body : AnimatedSprite2D

func on_process(_delta : float) :
	pass

func on_physics_process(_delta : float):
	if character:
		for child in character.get_children():
			if child != character.animation_player and child != animated_body:
				character.remove_child(child)
		await character.animation_player.animation_finished
		character.resource.is_dead = true
		character.died.emit()
		character.player.resources.Boss_Gollux = true
		#character.player.level = character.get_parent().get_path()
		if character.level_path:
			character.player.level = character.level_path
		character.player.spawn_point.global_position = character.global_position
		SaveLoad.game_save()
		
		#character.queue_free()

func enter():
	character.animation_player.play("die")

func exit():
	pass
