class_name PlayerStateFall extends PlayerState

var coyote_timer : float = 0
var jump_buffer_timer : float = 0

# What happens when this state is initialized?
func init() -> void:
	pass


# What happens when we enter this state?
func enter() -> void:
	player.add_debug_indicator(Color.CORAL)
	player.gravity_multiplier = player.fall_gravity_multiplier
	if player.velocity.y <= 0:
		player.velocity.y = player.velocity.y * player.variable_jump_release_multiplier
	
	# check if player jumped already, if not, allow for coyote time
	if player.previous_state != jump:
		coyote_timer = player.coyote_time
	pass


# What happens when we exit this state?
func exit() -> void:
	player.add_debug_indicator()
	player.gravity_multiplier = 1.0
	pass


# What happens when input is pressed?
# Returns the state that the player should switch to (or stay in)
func handle_input( event : InputEvent ) -> PlayerState:
	if event.is_action_pressed("jump"):
		jump_buffer_timer = player.jump_buffer
		if coyote_timer > 0:
			return jump
		
	return next_state


# What happens each process tick in this state?
func process(delta: float) -> PlayerState:
	coyote_timer -= delta
	jump_buffer_timer -= delta
	return next_state


# What happens each process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.run_speed * player.air_speed_multiplier
	if player.is_on_floor():
		if jump_buffer_timer > 0:
			return jump
		return idle
	return next_state
