extends Area2D

var spike_damage : float = 3.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#body.do_damage(spike_damage,self)
		body.resources.health -= spike_damage
		body.health_bar_ui.health = body.resources.health
		var pause : bool = true
		Effects.KnockBack(self,body)
		#if body.velocity.y == -800:
		Effects.FrameFreeze(0.1,0.2,pause)
		pause = false
		body.SFX[5].play()
		await body.SFX[5].finished
		#Effects.FrameFreeze(0.001,0.1)
		if body.spawn_pos:
			body.global_position = body.spawn_pos
			body.velocity = Vector2.ZERO
		else:
			body.global_position = body.spawn_point.global_position
			body.velocity = Vector2.ZERO
		if body.resources.health <= 0:
			body.die()
	if body.is_in_group("Enemy"):
		body.queue_free()
