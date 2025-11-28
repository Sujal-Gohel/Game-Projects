extends States

@export var character : Boss
@export var animated_body : AnimatedSprite2D

@onready var attacks = ["attack_1","attack_2"]
@onready var collision: CollisionShape2D = $"../../Hitbox/CollisionShape2D"
@onready var damage: float = character.resource.damage * 2

func on_process(_delta : float) :
	pass

func on_physics_process(_adelta : float):
	if character.player_detection.overlaps_body(character.player):
		var attack_frame : int = character.resource.attack_frame[attacks.find(animated_body.animation)]
		if animated_body.frame == attack_frame:
			collision.disabled = false
			if character.hitbox.overlaps_body(character.player):
				await animated_body.frame_changed
				if !collision.disabled:
					G_Signal.enemy_damage.emit(damage,character)
					collision.disabled = true
		if character.player.position.x < character.position.x:
			animated_body.flip_h = true
		else:
			animated_body.flip_h = false
		if animated_body.flip_h:
			collision.position.x = -24
		else:
			collision.position.x = 24
		if animated_body.animation == self.name:
			var random : String = attacks.pick_random()
			if character.resource.health <= 0:
				transition.emit("die")
			else:
				await animated_body.animation_finished
				transition.emit(random)
	else:
		if animated_body.animation == "attack_1" or animated_body.animation == "attack_2":
			await animated_body.animation_finished
		transition.emit("move")

func enter():
	if character.resource.health <= character.half_health:
		animated_body.speed_scale = 2
		damage = character.rage_damage
	animated_body.play("attack_2")

func exit():
	pass
