extends Node

signal on_stomp_begin
signal on_stomp_end

export(float) var stomp_speed = 2000.0

onready var m_owner = owner.get_parent() as KinematicBody2D

func _ready():
	set_physics_process(false)

func _physics_process(_delta):
	if m_owner.is_on_floor() == false:
		m_owner.move_and_slide(Vector2(0, stomp_speed), Vector2.UP)
	else:
		set_physics_process(false)
		get_parent().set_physics_process(true);
		emit_signal("on_stomp_end")
		
func handle_stomp():
	emit_signal("on_stomp_begin")
	set_physics_process(true)
	get_parent().set_physics_process(false);
