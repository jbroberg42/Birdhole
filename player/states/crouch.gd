class_name PlayerStateCrouch extends PlayerState


# What happens when this state is initialized?
func init() -> void:
	pass


# What happens when we enter this state?
func enter() -> void:
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	pass


# What happens when we exit this state?
func exit() -> void:
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	pass


# What happens when input is pressed?
# Returns the state that the player should switch to (or stay in)
func handle_input( event : InputEvent ) -> PlayerState:
	if event.is_action_pressed("jump"):
		if player.one_way_platform_raycast.is_colliding():
			player.position.y += 4
			return fall
		return jump
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.direction.y <= .5:
		return idle
	return next_state


# What happens each process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.run_speed * player.crouch_speed_multiplier
	if !player.is_on_floor():
		return fall
	return next_state
