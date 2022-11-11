extends Node2D

var freeze_movement = false
var enable_core_input = true

export(String) var move_left_key = "ui_left"
export(String) var move_right_key = "ui_right"
export(String) var jump_key = "ui_up"
export(String) var stomp_key = "ui_down"

export(String) var dash_key = "ui_dash"

export(float, 0, 1) var ground_acc = 0.9
export(float, 0, 1) var ground_friction = 0.05
export(float) var ground_speed = 350.0

export(float) var gravity = 35.0
export(float) var fall_speed = 800.0

export(float) var air_speed = 300.0

export(float) var ground_jump_force = 800.0
export(float) var air_jump_force = 600.0
export(int) var jump_count = 2

onready var m_owner = get_parent() as KinematicBody2D
export var m_velocity = Vector2()
var m_jump_counter = 0
	
func _physics_process(_delta):
	if Input.is_action_just_pressed(dash_key):
		if has_node("Dash"):
			$Dash.handle_dash()
			
	if freeze_movement:
		return

	if m_owner.is_on_floor():
		m_jump_counter = 0
		handle_ground_movement();
		if Input.is_action_just_pressed(jump_key):
			handle_ground_jump()
	else:
		handle_air_movement();
		if Input.is_action_just_pressed(jump_key):
			handle_air_jump()
		elif Input.is_action_just_pressed(stomp_key):
			if has_node("Stomp"):
				$Stomp.handle_stomp()
	
func handle_air_jump():
	if !enable_core_input:
		return
		
	if m_jump_counter >= jump_count:
		return
	
	m_velocity.y = -air_jump_force
	m_owner.move_and_slide(m_velocity)
	m_jump_counter += 1;
	
func handle_ground_jump():
	if !enable_core_input:
		return
		
	if jump_count <= 0:
		return
	
	m_velocity.y = -ground_jump_force
	m_owner.move_and_slide(m_velocity)
	m_jump_counter += 1;
	
func handle_ground_movement():
	var desired_velocity = Vector2.ZERO
	if Input.is_action_pressed(move_left_key):
		desired_velocity.x -= 1
	if Input.is_action_pressed(move_right_key):
		desired_velocity.x += 1
	
	if enable_core_input:
		desired_velocity = desired_velocity.normalized() * ground_speed;
	else:
		desired_velocity = Vector2.ZERO
		
	if desired_velocity.length() > 0:
		m_velocity = m_velocity.linear_interpolate(desired_velocity, ground_acc);
	else:
		m_velocity = m_velocity.linear_interpolate(Vector2.ZERO, ground_friction);

	if abs(m_velocity.x) < 1:
		m_velocity.x = 0
	
	m_velocity.y = gravity
	
	m_owner.move_and_slide(m_velocity, Vector2.UP)

func handle_air_movement():
	var desired_horizontal_speed = 0.0
	if Input.is_action_pressed(move_left_key):
		desired_horizontal_speed = -1
	if Input.is_action_pressed(move_right_key):
		desired_horizontal_speed = 1
	
	if enable_core_input:
		desired_horizontal_speed *= air_speed;
		m_velocity.x = desired_horizontal_speed

	m_velocity.y += gravity;
	m_velocity.y = clamp(m_velocity.y, -INF, fall_speed)
	
	m_owner.move_and_slide(m_velocity, Vector2.UP)
	if m_owner.is_on_ceiling():
		m_velocity.y = gravity

func reset_velocity():
	m_velocity = Vector2.ZERO
