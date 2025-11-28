extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("FadeIn")

#func _process(_delta: float) -> void:
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#animation_player.play("FadeOut")
		#await animation_player.animation_finished
		#G_Signal.reload.emit()
		#await G_Signal.reload

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Continue"):
		animation_player.play("FadeOut")
		await animation_player.animation_finished
		G_Signal.reload.emit()
		await G_Signal.reload
