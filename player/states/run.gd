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
func handle_input( event : InputEvent ) -> PlayerState:
	if event.is_action_pressed("jump"):
		return jump
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	return next_state


# What happens each process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.run_speed
	if !player.is_on_floor():
		return fall
	return next_state
