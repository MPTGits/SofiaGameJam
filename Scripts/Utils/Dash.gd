extends Tween

signal on_dash_begin
signal on_dash_end

export(float) var dash_distance = 200.0
export(float) var dash_duration = 0.3

onready var m_owner = owner.get_parent() as KinematicBody2D
var m_nextPos = Vector2.ZERO
var m_nextPosLinear = Vector2.ZERO

func _ready():
	set_physics_process(false)

func handle_dash():
	if !m_owner.has_method("is_facing_left"):
		return
		
	remove_all()
	
	var dash_direction = 0
	var is_left = m_owner.call("is_facing_left");
	dash_direction = -dash_distance if is_left else dash_distance
		
	interpolate_property(self, 'm_nextPos', 
		m_owner.position,
		m_owner.position + Vector2(dash_direction, 0),
		dash_duration, 
		Tween.TRANS_EXPO, Tween.EASE_OUT)
	
	interpolate_property(self, 'm_nextPosLinear', 
		m_owner.position,
		m_owner.position + Vector2(dash_direction, 0),
		dash_duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN)
		
	start()

	set_physics_process(true)
	get_parent().set_physics_process(false);
	m_owner.set_physics_process(false);
	emit_signal("on_dash_begin")
	
func _physics_process(_delta):
	var desired_pos = m_nextPos - m_owner.position
	m_owner.move_and_collide(desired_pos)

func _on_Dash_tween_all_completed():
	set_physics_process(false)
	get_parent().set_physics_process(true);
	m_owner.set_physics_process(true);
	get_parent().m_velocity = Vector2.ZERO
	emit_signal("on_dash_end")
	
func get_linear_pos():
	var is_left = m_owner.call("is_facing_left");
	if is_left:
		if abs(m_nextPosLinear.x) > abs(m_owner.position.x):
			return m_nextPosLinear
		return m_owner.position
	else:
		if abs(m_nextPosLinear.x) < abs(m_owner.position.x):
			return m_nextPosLinear
		return m_owner.position
