extends AnimationTree

var playback : AnimationNodeStateMachinePlayback
var player_node: KinematicBody2D
var player_sprite: AnimatedSprite
var weapon_name: String

func _ready():
	playback = get("parameters/playback")
	player_node = get_parent();
	weapon_name = player_node.weapon
	player_sprite = player_node.get_node('AnimatedSprite')
	player_sprite.frames.set_animation_speed('grenadeThrowerRun',12.0)
	player_sprite.frames.set_animation_speed('katanaRun',12.0)
	player_sprite.frames.set_animation_speed('Run',12.0)
	
	player_sprite.frames.set_animation_speed('katanaAttack',20.0)

func _input(event):
	if event.is_action_pressed("ui_attack") and player_node.isAttacking == false:
		player_sprite.play('katanaAttack')


func _physics_process(delta):
	var isMoving = player_node.is_on_floor() and player_node.move_component.m_velocity.x != 0
	print(player_sprite.frame)
	if isMoving == true:
		player_sprite.play(weapon_name + 'Run')

	if isMoving == false and get_parent().isAttacking == false:
		player_sprite.play(weapon_name + 'Idle')
		
	if not player_node.is_on_floor():
		player_sprite.play(weapon_name + 'Jump')


#	if get_parent().is_on_floor() == false and get_parent().move_component.m_velocity.y < 0:
#		playback.travel("jump")
