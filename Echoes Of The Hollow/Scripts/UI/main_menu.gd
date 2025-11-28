extends Node2D

@onready var MAIN = preload("res://Scenes/main.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = %Player
@onready var parallax_background: ParallaxBackground = %ParallaxBackground

var scroll_speed : int = 500

func _ready() -> void:
	LoadScreen.play("fade_out")
	animated_sprite_2d.play("default")

func _process(delta: float) -> void:
	parallax_background.scroll_offset.x -= scroll_speed * delta
	if parallax_background.scroll_offset.x <= -1920:
		parallax_background.scroll_offset.x = 0

func _on_start_pressed() -> void:
	#MAIN.instantiate()
	#load(MAIN)
	#await get_tree().create_timer(3).timeout
	LoadScreen.animation_player.play("fade_in")
	await LoadScreen.animation_player.animation_finished
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_restart_pressed() -> void:
	var file = FileAccess
	if file.file_exists(SaveLoad.save_path):
		DirAccess.remove_absolute(SaveLoad.save_path)
		print("Restarted")
