class_name PlayerStateRun extends PlayerState

# What happens when this state is initialized?
func init() -> void:
	pass


# What happens when we enter this state?
func enter() -> void:
	pass


# What happens when we exit this state?
func exit() -> void:
	pass


# What happens when input is pressed?
# Returns the state that the player should switch to (or stay in)
func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	return next_state


# What happens each process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
