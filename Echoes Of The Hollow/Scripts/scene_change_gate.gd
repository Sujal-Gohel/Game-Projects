extends Area2D

@export var NextScene : String
@export var PlayerPos : Vector2
@export var PlayerJumponEnter : bool = false

var main
var next
var new_level

func _ready() -> void:
	main = get_parent().get_parent()
	next = load(NextScene)
	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		LoadScreen.play("fade_in")
		SceneChange.Activate = true
		SceneChange.PlayerPos = PlayerPos
		SceneChange.PlayerJumponEnter = PlayerJumponEnter
		new_level = next.instantiate()
		position = PlayerPos
		SceneChange.SceneChange.emit(main,new_level)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		if body.global_position >= PlayerPos or body.global_position <= PlayerPos:
			body.global_position = PlayerPos
