extends KinematicBody2D

onready var move_component = $MoveComponenta

var spriteOffset = 30 # Current sprite is incorectly pivoted, so we use offset to fix that
export var damage = 10 # This is used for testing purposes. It will be moved to a better place later!
var isAttacking = false

func _input(event):
	if event.is_action_pressed("ui_attack") && $AttackTimer.is_stopped():
		isAttacking = true;
		move_component.freeze_movement = true
		move_component.enable_core_input = false
		
func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		$Sprite.offset.x = -40
		$Sprite/Area2D/Sword.position.x = -72
		
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		$Sprite.offset.x = 0
		$Sprite/Area2D/Sword.position.x = 17
		
func OnAttackAnimationFinish():
	isAttacking = false;
	$AttackTimer.start()
	move_component.freeze_movement = false
	move_component.enable_core_input = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.TakeDamage(damage);

func is_facing_left():
	return $Sprite.flip_h
	
