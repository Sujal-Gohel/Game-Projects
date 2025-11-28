extends CanvasLayer

@export var player : Player

const GAME_OVER_SCREEN = preload("res://Scenes/UI/game_over_screen.tscn")
var game_over

func _ready() -> void:
	player.gameover.connect(GameOver)
	game_over = GAME_OVER_SCREEN.instantiate()
	#G_Signal.reload.connect(on_reload)

func GameOver():
	#player.remove_child(player.state_machine)
	#player.remove_child(player.collision)
	#player.remove_child(player.animation_player)
	if !G_Signal.reload.is_connected(on_reload):
		G_Signal.reload.connect(on_reload)
		player.gameover.disconnect(GameOver)
	call_deferred("add_child",game_over)
	game_over.request_ready()

func on_reload():
	if !player.gameover.is_connected(GameOver):
		G_Signal.reload.disconnect(on_reload)
		player.gameover.connect(GameOver)
		load_new_level(get_parent())
		player.call_deferred("add_child",player.collision)
		player.call_deferred("add_child",player.state_machine)
		player.call_deferred("add_child",player.animation_player)
		#print(player.get_path_to(player.collision))
		player.global_position = player.spawn_point.global_position
		player.reset_health()
		call_deferred("remove_child",game_over)
	LoadScreen.play("fade_out")

func load_new_level(main):
	var level = load(SaveLoad.game_load())
	var new_level = level.instantiate()
	for child in main.get_children():
		if child.is_in_group("Level"):
			main.call_deferred("remove_child",child)
			main.call_deferred("add_child",new_level)
