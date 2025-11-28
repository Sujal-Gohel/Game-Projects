extends Node2D

@onready var doors: Hidden_doors = $LevelMap/Doors
@onready var villager_2: NPC = $NPCContainer/Villager2

var can_remove : bool = true

func _process(_delta: float) -> void:
	if QuestManager.quest_list.has(villager_2.quest.quest_id):
		var Status = QuestManager.quest_list[villager_2.quest.quest_id]
		if can_remove and Status == "PROGESSING":
			doors.global_position = Vector2(0,600)
			can_remove = false
