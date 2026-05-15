class_name PlayerStateIdle extends PlayerState


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
	if event.is_action_pressed("jump") && player.is_on_floor():
		return jump
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	elif player.direction.y > 0.5:
		return crouch
	return next_state


# What happens each process tick in this state?
func physics_process(delta: float) -> PlayerState:
	player.velocity.x = 0
	return next_state
