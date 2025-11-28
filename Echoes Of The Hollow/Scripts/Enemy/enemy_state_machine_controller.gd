class_name FiniteStateMachineController
extends Node

@export var state_machine_controller : StateMachine
@export var enemy : Enemy

@onready var timer: Timer = $"../Timer"


func _on_timer_timeout() -> void:
	if state_machine_controller.current_state.name == "idle":
		state_machine_controller.transition_state("walk")
	elif state_machine_controller.current_state.name == "walk":
		state_machine_controller.transition_state("idle")
	timer.wait_time = randf_range(1,3)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		state_machine_controller.transition_state("attack")

func _on_hitbox_body_exited(body: Node2D) -> void:
	await enemy.animated_sprite_2d.animation_finished
	if body.is_in_group("player"):
		if !enemy.AttackMode.overlaps_body(enemy.player):
			state_machine_controller.transition_state("chase")
	else :
		state_machine_controller.transition_state("chase")
