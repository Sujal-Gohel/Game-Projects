extends Node

signal show_tutorial

var SaveData
var default_level : String = "res://Scenes/Level/mossy_biome.tscn"
var default_spawn = Vector2(250,700)

var save_path : String = "user://Saved_Resource.tres"

func _ready() -> void:
	pass

func game_save():
	var player := get_tree().get_first_node_in_group("player") as Player
	var default_health := player.health
	SaveData = SavedData.new()
	player.resources.health = default_health
	SaveData.player_resources = player.resources
	SaveData.level = player.level
	SaveData.position = player.spawn_point.global_position
	SaveData.QuestList = QuestManager.quest_list
	#ResourceSaver.save(SaveData,"user://Saved_Resource.tres")
	ResourceSaver.save(SaveData,save_path)
		

func game_load():
	var player := get_tree().get_first_node_in_group("player") as Player
	var default_health := player.health
	SaveData = SavedData.new()
	if FileAccess.file_exists(save_path):
		SaveData = load(save_path) as SavedData
	else:
		var file = FileAccess.open(save_path,FileAccess.WRITE)
		player.resources.health = default_health
		SaveData.player_resources = player.resources
		SaveData.level = default_level
		SaveData.position = player.spawn_point.global_position
		ResourceSaver.save(SaveData , save_path)
		file.close()
		show_tutorial.emit()
	if SaveData:
		player.resources.health = default_health
		player.resources = SaveData.player_resources
		player.global_position = SaveData.position
		QuestManager.quest_list = SaveData.QuestList
		if player.level:
			player.level = SaveData.level
		else:
			player.level = default_level
		if player.spawn_point:
			player.spawn_point.global_position = SaveData.position
		else:
			player.spawn_point.global_position = default_spawn
		return player.level
	else:
		player.global_position = default_spawn
		player.resources.health = default_health
		player.spawn_point.global_position = default_spawn
		return default_level
