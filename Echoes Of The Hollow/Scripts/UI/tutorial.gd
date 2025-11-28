extends CanvasLayer

func _ready() -> void:
	SaveLoad.show_tutorial.connect(show_tutorial)
	$Tutorial/AnimatedSprite2D.play("default")

func show_tutorial():
	if !visible :
		visible = true
	get_tree().paused = true
	$AnimationPlayer.play("show")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Continue"):
		get_tree().paused = false
		$AnimationPlayer.play_backwards("show")
		await $AnimationPlayer.animation_finished
		queue_free()
