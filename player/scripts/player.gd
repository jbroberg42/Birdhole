class_name Player extends CharacterBody2D

const DEBUG_INDICATOR = preload("uid://7s2m781vfrmb")

#region /// Export Variables
@export var jump_velocity : float  = -500
@export var air_speed_multiplier : float = 1
@export var variable_jump_release_multiplier : float = 0.5
@export var coyote_time : float = 0.12
@export var jump_buffer : float = 0.2
@export var fall_gravity_multiplier = 1.165

@export var run_speed : float = 100
@export var run_accel_time : float = .3
@export var run_decel_time : float = .3
#endregion

#region /// State Machine Variables
var states : Array[ PlayerState ]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// standard variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_multiplier : float = 1.0
#endregion


func _ready() -> void:
	# initialize states
	initialize_states()
	pass


func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	pass


func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))
	pass


func _physics_process(delta: float) -> void:
	velocity.y += gravity * gravity_multiplier * delta
	change_state(current_state.physics_process(delta))
	move_and_slide()
	pass


func initialize_states() -> void:
	states = [ ]
	# gather all states
	for c in $States.get_children():
		if c is PlayerState:
			states.append(c)
			c.player = self
		pass
	
	if states.size() == 0:
		return
	
	# initialize all states
	for state in states:
		state.init()
		
	# set our first state
	change_state( current_state )
	current_state.enter()
	$Label.text = current_state.name
	pass



func change_state(new_state : PlayerState) -> void:
	# check if new state is new
	if new_state == null:
		return
	elif new_state == current_state:
		return
		
	# if the current state is valid, call exit function
	if current_state:
		current_state.exit()
	
	# put the new state at the beginning of the states array and call its enter function
	states.push_front(new_state)
	current_state.enter()
	
	# keep the array a manageable size
	states.resize(3)
	$Label.text = current_state.name
	pass


func update_direction() -> void:
	#var prev_direction : Vector2 = direction
	#var x_axis = Input.get_axis("left", "right")
	#var y_axis = Input.get_axis("jump", "down")
	#direction = Vector2(x_axis, y_axis)
	direction = Input.get_vector("left", "right", "up", "down")
	pass
	
func add_debug_indicator(color : Color = Color.RED) -> void:
	var d : Node2D = DEBUG_INDICATOR.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer(3.0).timeout
	d.queue_free()
	pass
