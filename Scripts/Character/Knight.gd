extends KinematicBody2D

onready var move_component = $MoveComponenta

var spriteOffset = 30 # Current sprite is incorectly pivoted, so we use offset to fix that
export var damage = 10 # This is used for testing purposes. It will be moved to a better place later!
var isAttacking = false
var weapon = 'katana'

func _input(event):
	if event.is_action_pressed("ui_attack") && $AttackTimer.is_stopped():
		isAttacking = true;
		move_component.freeze_movement = true
		move_component.enable_core_input = false
		
func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.offset.x = 0
		
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.offset.x = -40

		
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
	
