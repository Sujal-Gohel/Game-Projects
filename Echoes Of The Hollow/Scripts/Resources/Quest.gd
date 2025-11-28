class_name Quest
extends Resource

enum QuestType{
	KILL,
	EXPLORE,
	TALK,
	COLLECT,
	POWER
}

enum Rewards{
	ITEM,
	POWER
}

enum Powers{
	NULL,
	DASH,
	SWORD
}

@export var has_quest: bool = false
@export var quest_id : int
@export var title : String
@export_multiline var description : String
@export var Type : QuestType
@export var Status : QuestManager.Status
@export var Rewards_Type : Rewards

var killed : int
var Explored : bool
var Talked : bool
var Collected : int
#var Claimed : Bool

@export_group("Kill","Kill_")
@export var Kill_Enemy : String
@export var Kill_Required : int

@export_group("Explore","Area_")
@export var Area_Find : PackedScene

@export_group("Talk","Talk_")
@export var Talk_NPC : String

@export_group("Collect","Collect_")
@export var Collect_Item : String
@export var Collect_Quantity : int

@export_group("Rewards","Give_")
@export var Give_Item : String
@export var Give_Power : Powers
