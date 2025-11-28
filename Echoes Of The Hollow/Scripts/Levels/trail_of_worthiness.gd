extends Node2D

@onready var enemy_container: Node2D = $EnemyContainer
@onready var enemy_spawner: Timer = $EnemySpawner
@onready var doors: TileMapLayer = $TileMapContainer/Doors
@onready var trail_start: Area2D = $TrailStart

@export var ENEMY : PackedScene

var Enemy_Instance
var enemy_count : int = 0
var removed : bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if QuestManager.quest_list[1] == "COMPLETED":
		remove_obj()

func _on_enemy_spawner_timeout() -> void:
	if enemy_count < QuestManager.quest.Kill_Required:
		Enemy_Instance = ENEMY.instantiate()
		enemy_container.add_child(Enemy_Instance)
		enemy_count += 1
		var random_x = randf_range(300,1600)
		var random_y = randf_range(350,900)
		Enemy_Instance.global_position = Vector2(random_x,random_y)
		enemy_spawner.wait_time -= 0.5
		if enemy_spawner.wait_time <= 2:
			enemy_spawner.wait_time = 2
		if !enemy_spawner.autostart:
			enemy_spawner.autostart = true
	else:
		enemy_spawner.autostart = false
		enemy_spawner.stop()

func _on_trail_start_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		enemy_spawner.start()
	call_deferred("remove_child",trail_start)

func remove_obj():
	if !removed:
		#call_deferred("remove_child",doors)
		#remove_child(doors)
		doors.queue_free()
		removed = true
