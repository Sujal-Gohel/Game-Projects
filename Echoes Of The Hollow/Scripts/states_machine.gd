class_name StateMachine
extends Node

@export var initial_state : States

var state : Dictionary = {}
var current_state : States
var current_state_name : String

func _ready() -> void:
	for child in get_children():
		if child is States:
			state[child.name.to_lower()] = child
		
		if initial_state :
			initial_state.enter()
			current_state = initial_state 
		
		child.transition.connect(transition_state)
		

func _process(delta: float) -> void:
	if current_state:
		current_state.on_process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.on_physics_process(delta)
	#if get_parent() is Boss:
		#print("State : " , current_state.name.to_lower())
	#if get_parent() is Player:
		#print("State : " , current_state.name.to_lower())

func transition_state(state_name : String):
	if state_name == current_state_name.to_lower() :
		return
	var new_state = state.get(state_name.to_lower())
	
	if !new_state  :
		return
	
	if current_state :
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
	current_state_name = new_state.name.to_lower()
