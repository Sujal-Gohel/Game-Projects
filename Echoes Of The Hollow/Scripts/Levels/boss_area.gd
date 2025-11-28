extends Node2D

@onready var boss: Boss = $Boss
@onready var doors: TileMapLayer = $Doors
@onready var boss_slain_screen: CanvasLayer = $BossSlainScreen

const GAME_COMPLETE = preload("uid://bmge3etijt1b7")

var com
#var door_remove : bool

func _ready() -> void:
	com = GAME_COMPLETE.instantiate()
	if boss.resource.is_dead:
		remove_child(doors)
	boss.died.connect(on_boss_died)

func on_boss_died():
	if boss.resource.is_dead:
		remove_child(boss)
		boss_slain_screen.visible = true
		G_Signal.gamecompleted.emit()
		boss.died.disconnect(on_boss_died)
