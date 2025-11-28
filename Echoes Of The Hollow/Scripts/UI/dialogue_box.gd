class_name DialogueBox extends CanvasLayer

@onready var content: Label = $Panel/Content
@onready var npc_name: Label = $Panel/Name
@onready var choice: Control = $Choice

var talk_type : String
var dialogues : Array = []
var dialogues_index : int = -1
var QUEST : Quest
var shown : bool = false

func _ready() -> void:
	G_Signal.start_dialouge.connect(start_dialogue)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Continue"):
		if talk_type == DialogueManager.Type.keys()[0]:# and QUEST == null:
			print_normal_dialogauges(npc_name.text)
		if talk_type == DialogueManager.Type.keys()[1] and QUEST != null:
			print_quest_dialogauges(npc_name.text,QUEST)

func start_dialogue(npc : String , type : String,quest : Quest):
	if !shown:
		shown = true
		npc_name.text = npc
		talk_type = type
		QUEST = quest
		# IF DIALOGUE IS NORMAL TYPE
		if type == DialogueManager.Type.keys()[0]:
			print_normal_dialogauges(npc)
		# IF DIALOGUE IS QUEST TYPE
		if type == DialogueManager.Type.keys()[1] and quest != null:
			print_quest_dialogauges(npc,quest)

func finish_dialogues():
	dialogues.clear()
	dialogues_index = -1
	if dialogues.is_empty() and dialogues_index == -1:
		shown = false
		G_Signal.finish_dialouge.emit()
	else:
		finish_dialogues()
	if QuestManager.quest_status == QuestManager.Status.COMPLETED:
		QuestManager.claim_reward()
	if choice.visible:
		choice.visible = false

func print_normal_dialogauges(npc):
	if dialogues.is_empty():
		for dialo in DialogueManager.Dialogues[npc]:
			dialogues.append(dialo)
	dialogues_index += 1
	if dialogues_index < dialogues.size():
		content.text = dialogues[dialogues_index]
	elif dialogues_index >= dialogues.size():
		finish_dialogues()

func print_quest_dialogauges(npc,_que : Quest):
	if dialogues.is_empty():
		for dialo in DialogueManager.Dialogues[npc][QUEST.Status]:
			dialogues.append(dialo)
	dialogues_index += 1
	if dialogues_index < dialogues.size():
		content.text = dialogues[dialogues_index]
		if dialogues_index == dialogues.size()-1:
			if QUEST.Status == QuestManager.Status.NOT_STARTED:
				choice.visible = true
			elif QUEST.Status == QuestManager.Status.COMPLETED:
				QuestManager.claim_reward()
	else:
		finish_dialogues()

func _on_accept_pressed() -> void:
	QuestManager.quest_start(QUEST)
	finish_dialogues()

func _on_deny_pressed() -> void:
	start_dialogue(npc_name.text,talk_type,QUEST)
