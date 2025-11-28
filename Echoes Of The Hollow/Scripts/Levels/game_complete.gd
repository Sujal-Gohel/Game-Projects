extends Control

func _ready() -> void:
	G_Signal.gamecompleted.connect(Show)

func Show():
	$AnimationPlayer.play("fade_in")
