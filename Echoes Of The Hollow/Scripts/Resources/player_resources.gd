class_name Player_Resource
extends Resource

@export var health : float
@export var damage : float
@export var slide_speed : float
@export var move_speed : float
@export var max_jump_height : float
@export var jump_force : float
@export var gravity : float
@export var Boss_Gollux : bool = false
@export var dash_speed : float
@export var dash_time : float
@export var Has_Sword : bool = false

@export_group("Powers","Power_")
@export var Power_Dash : bool = false
@export var Power_Double_Jump : bool = false
@export var Power_Wall_Jump : bool = false

#@export_category("attack_combo") 
@export_group("Attacks","Frames_")
@export var Frames_attack1 : int
@export var Frames_attack2 : int
@export var Frames_attack3 : int

@export var attack_frame : Dictionary
