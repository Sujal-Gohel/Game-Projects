extends Node

func FrameFreeze(timeScale : float , Duration : float , paused : bool = false):
	if !paused:
		Engine.time_scale = timeScale
		await get_tree().create_timer(timeScale * Duration).timeout
		Engine.time_scale = 1
	else:
		get_tree().paused = true
		await get_tree().create_timer(0.5).timeout
		get_tree().paused = false
	#print("Frame Freezed")

func KnockBack(Dealer : Node2D , Target : CharacterBody2D):
	if Target.is_in_group("player") and (Dealer.is_in_group("Enemy") or Dealer.is_in_group("Boss")):
		#print("Target Is Player And Dealer is Enemy")
		if Dealer.animated_sprite_2d.flip_h:
			Target.velocity = Vector2(move_toward(Target.velocity.x,-1000,1000),move_toward(Target.velocity.x,0,1000))
		else:
			Target.velocity = Vector2(move_toward(Target.velocity.x,1000,1000),move_toward(Target.velocity.x,0,1000))
	if (Target.is_in_group("Enemy") or Target.is_in_group("Boss")) and Dealer.is_in_group("player"):
		#print("Target Is Enemy And Dealer is Player")
		if Dealer.animated_sprite_2d.flip_h:
			Target.velocity = Vector2(move_toward(Target.velocity.x,1000,1000),move_toward(Target.velocity.x,0,1000))
		else:
			Target.velocity = Vector2(move_toward(Target.velocity.x,-1000,1000),move_toward(Target.velocity.x,0,1000))
	if Target.is_in_group("player") and !(Dealer.is_in_group("Enemy") or Dealer.is_in_group("Boss")):
		#print("Target Is Player And Dealer is Spikes")
		Target.velocity = Vector2(move_toward(Target.velocity.x,0,1000),move_toward(Target.velocity.x,-800,1000))
	Target.move_and_slide()
	pass
