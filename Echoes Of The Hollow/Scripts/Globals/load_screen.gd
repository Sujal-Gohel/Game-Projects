extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play(anim : String):
	animation_player.play(anim.to_lower())
