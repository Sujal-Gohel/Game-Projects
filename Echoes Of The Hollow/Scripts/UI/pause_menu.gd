extends CanvasLayer

@onready var MAIN_MENU = preload("res://Scenes/UI/main_menu.tscn")

var paused : bool = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause") and paused:
		if visible and get_tree().paused:
			get_tree().paused = false
			visible = false
			

func _on_resume_pressed() -> void:
	if visible and get_tree().paused:
		visible = false
		get_tree().paused = false


func _on_quit_pressed() -> void:
	if visible and get_tree().paused:
		get_tree().paused = false
		LoadScreen.play("fade_in")
		get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
