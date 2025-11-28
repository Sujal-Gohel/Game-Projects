extends Node

signal killed
signal receive

enum Status{
	NOT_STARTED,
	PROGESSING,
	COMPLETED,
	REWARDS
}

var quest : Quest
var quest_list : Dictionary = {}
var active_quest : Dictionary = {}
var quest_status = Status.NOT_STARTED

func _ready() -> void:
	killed.connect(update_quest)

func quest_start(que : Quest):
	quest = que
	if quest.Status == Status.NOT_STARTED:
		quest_status = Status.PROGESSING
		quest.Status = quest_status
	if !quest_list.has(quest.quest_id):
		quest_list.get_or_add(quest.quest_id,Status.keys()[quest.Status])
	print("Started")
	update_quest()
	pass

func update_quest(kill_add=0):#,explored = false,talked=false,collected=0):
	
	if quest.Status == Status.PROGESSING:
		match quest.Type:
			0: #KILL
				#print("update kill")
				Kill_Quest(kill_add)
			1: #EXPLORE
				pass
				#print("update Exploration")
			2: #TALK
				pass
				#print("update Talked")
			3: #COLLECT
				pass
				#print("update Collection")
			4: #POWER
				print("Updated")
				quest_complete()
				pass

func quest_complete() -> bool:
	if quest.Status == Status.PROGESSING:
		quest_status = Status.COMPLETED
		quest.Status = quest_status
		quest_list.set(quest.quest_id,Status.keys()[quest.Status])
		return true
	else:
		return false

func claim_reward():
	if quest_list.has(quest.quest_id) and quest.Status == Status.COMPLETED:
		quest.Status = Status.REWARDS
		quest_list.set(quest.quest_id,Status.keys()[quest.Status])
		receive.emit(quest.Rewards.keys()[quest.Rewards_Type],quest.Powers.keys()[quest.Give_Power])
		

func Kill_Quest(kill_add):
	var kill_goal : int = quest.Kill_Required
	quest.killed += kill_add
	if quest.killed >= kill_goal:
		quest_complete()
