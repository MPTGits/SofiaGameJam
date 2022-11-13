extends KinematicBody2D

export(float, 0, 1) var accelaration = 0.08
export(float, 0, 1) var friction = 0.03
export(float) var speed = 550.0
export(float) var gravity = 15.0
export(String) var moving_direction = ''

onready var GRENADE = preload("res://Projectiles/Grenade.tscn")

var m_velocity = Vector2()
var m_smokeScaleCoeff = 0.0

var canAttack = true

func _physics_process(delta):
	var desired_velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_fly"):
		m_smokeScaleCoeff = min(m_smokeScaleCoeff + delta, 1.0)
		desired_velocity.y -= 1
	else:
		m_smokeScaleCoeff = max(m_smokeScaleCoeff - (delta * 1.5), 0.0)
	
	HandleSmokeAnim()
		
	desired_velocity = desired_velocity.normalized() * speed;
	
	if desired_velocity.length() > 0:
		m_velocity = m_velocity.linear_interpolate(desired_velocity, accelaration);
	else:
		m_velocity = m_velocity.linear_interpolate(Vector2.ZERO, friction);
	
	m_velocity.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		m_velocity.x += speed * accelaration;
		moving_direction = 'right'
	
	if Input.is_action_pressed("ui_left"):
		m_velocity.x -= speed * accelaration;
		moving_direction = 'left'
	
	move_and_slide(m_velocity, Vector2.UP)

func HandleSmokeAnim():
	$AnimatedSprite.scale = Vector2(m_smokeScaleCoeff, m_smokeScaleCoeff)
	$AnimatedSprite.modulate.a = m_smokeScaleCoeff * 1.5

func TakeDamage(damage):
	$PlayerUI.HealthBar.TakeDamage(damage)

func TakeBoost(boost):
	$PlayerUI.EnergyBar.TakeBoost(boost)

func _input(event):
	if event.is_action_pressed("ui_attack") and canAttack:
		var grenade = GRENADE.instance()
		grenade.set_as_toplevel(true)
		get_tree().get_root().add_child(grenade)
		grenade.Init($WeaponShooting.global_position, false, self, null)
		
		Globals.CreateExplosionAnim($WeaponShooting.global_position, "shooting")
		
		canAttack = false
		$Timer.start()


func _on_Timer_timeout():
	canAttack = true
