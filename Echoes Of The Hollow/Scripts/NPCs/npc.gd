class_name NPC
extends Node2D

enum Category {
	Idle,
	Walk
}

@onready var player_detection: Area2D = $PlayerDetection
@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var ui: Control = $UI
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var Name : String
@export var Mode : Category
@export var type : DialogueManager.Type
@export var quest : Quest

const DIALOGUE_BOX = preload("res://Scenes/UI/dialogue_box.tscn")
var animated_body : AnimatedSprite2D
var dialogue_box

func _ready() -> void:
	for child in get_children():
		if child is AnimatedSprite2D:
			animated_body = child
			animated_body.play("default")
			#print(child)
	dialogue_box = DIALOGUE_BOX.instantiate()
	G_Signal.finish_dialouge.connect(dialogue_finished)

func _process(_delta: float) -> void:
	if player:
		if QuestManager.quest_list.has(quest.quest_id):
			var state = QuestManager.quest_list[quest.quest_id]
			match state:
				"NOT_STARTED":
					quest.Status = 0 as QuestManager.Status
				"PROGESSING":
					quest.Status = 1 as QuestManager.Status
				"COMPLETED":
					quest.Status = 2 as QuestManager.Status
				"REWARDS":
					quest.Status = 3 as QuestManager.Status
		if player_detection.overlaps_body(player):
			if GameInput.interact():
				ui.visible = false
				if dialogue_box.get_parent() != self:
					add_child(dialogue_box)
					#call_deferred("add_child",dialogue_box)
					player.call_deferred("remove_child",player.state_machine)
					player.canvas_layer.visible = false
					create_tween().tween_property(player.camera_2d,"zoom",Vector2(2.3,2.3),0.2)
				G_Signal.start_dialouge.emit(Name,DialogueManager.Type.keys()[type],quest)

func dialogue_finished():
	if dialogue_box.get_parent() == self:
		remove_child(dialogue_box)
		player.call_deferred("add_child",player.state_machine)
		player.canvas_layer.visible = true
		create_tween().tween_property(player.camera_2d,"zoom",Vector2(1.7,1.7),0.2)
		#player.camera_2d.zoom = Vector2(1.7,1.7)
		#player.tween.tween_property(player.camera_2d,"zoom",Vector2(1.7,1.7),0.2)


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		ui.visible = true
		animation_player.play("FadeIn")


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation_player.play_backwards("FadeIn")
		await animation_player.animation_finished
		ui.visible = false
