@icon("res://player/states/state.svg")
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region /// state references
# reference to all other states
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
#endregion


# What happens when this state is initialized?
func init() -> void:
	print ("init: ", name)
	pass


# What happens when we enter this state?
func enter() -> void:
	print ("enter: ", name)
	pass


# What happens when we exit this state?
func exit() -> void:
	print ("exit: ", name)
	pass


# What happens when input is pressed?
# Returns the state that the player should switch to (or stay in)
func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	return next_state


# What happens each process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	return next_state
