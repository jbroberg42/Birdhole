class_name PlayerStateJump extends PlayerState

# What happens when this state is initialized?
func init() -> void:
	pass


# What happens when we enter this state?
func enter() -> void:
	player.add_debug_indicator(Color.GREEN)
	player.velocity.y = player.jump_velocity
	pass


# What happens when we exit this state?
func exit() -> void:
	pass


# What happens when input is pressed?
# Returns the state that the player should switch to (or stay in)
func handle_input( event : InputEvent ) -> PlayerState:
	if event.is_action_released("jump"):
		return fall
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	return next_state


# What happens each physics tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.run_speed * player.air_speed_multiplier
	if player.velocity.y >= 0:
		return fall
	return next_state
