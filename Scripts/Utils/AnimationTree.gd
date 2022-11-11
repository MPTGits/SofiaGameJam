extends AnimationTree

var playback : AnimationNodeStateMachinePlayback

func _ready():
	playback = get("parameters/playback")

func _input(event):
	if event.is_action_pressed("ui_attack") and get_parent().isAttacking == false:
		playback.travel("attack");

func _physics_process(delta):
	var isMoving = get_parent().is_on_floor() and get_parent().move_component.m_velocity.x != 0

	self["parameters/conditions/IsMoving"] = isMoving
	self["parameters/conditions/NotMoving"] = not isMoving

	if isMoving == false and get_parent().isAttacking == false:
		playback.travel("idle")

#	if get_parent().is_on_floor() == false and get_parent().move_component.m_velocity.y < 0:
#		playback.travel("jump")
