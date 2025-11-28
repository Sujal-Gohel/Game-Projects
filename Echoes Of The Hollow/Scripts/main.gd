extends Node2D

@onready var pause_menu: CanvasLayer = $CanvasLayer/PauseMenu

var level

func _ready() -> void:
	level = load(SaveLoad.game_load())
	var new_level = level.instantiate()
	for child in get_children():
		if child.is_in_group("Level"):
			call_deferred("remove_child",child)
			call_deferred("add_child",new_level)
	SceneChange.SceneChange.connect(on_scene_change)
	LoadScreen.animation_player.play("fade_out")

func _process(_delta: float) -> void:
	if pause_menu.paused:
		pause_menu.paused = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		if !pause_menu.visible and !pause_menu.paused:
			print("Paused")
			get_tree().paused = true
			pause_menu.visible = true
			pause_menu.paused = true

func on_scene_change(main,new_level):
	#LoadScreen.play("fade_in")
	for child in main.get_children():
		if child.is_in_group("Level"):
			main.call_deferred("remove_child",child)
			main.call_deferred("add_child",new_level)
	LoadScreen.play("fade_out")
