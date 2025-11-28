extends Camera2D

@export var player : Player

func _process(_delta: float) -> void:
	if player != null :
		global_position = player.global_position
