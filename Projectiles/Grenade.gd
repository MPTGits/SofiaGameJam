extends Area2D

var Damage = 100
var enemies = []
var enemyGroup = null

export(int) var initialLenght = 100
export(int) var fallLenght = 130

var positionA := Vector2()
var positionB := Vector2()
var positionC := Vector2()

var air_duration = 0.8
var air_elapsed_time = 0.0

func Init(grenadeInfo: ProjectileInfo):
	$AnimatedSprite.play("default")
	
	if grenadeInfo.projectileOwner.is_in_group("enemy"):
		Damage = 10
		enemyGroup = "player"
		
		set_collision_layer_bit(3, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(4, true)
		
		positionA = grenadeInfo.position
		positionB = Vector2(grenadeInfo.position.x - 300, grenadeInfo.position.y - 400)
		positionC = Vector2(grenadeInfo.target.global_position.x + fallLenght, grenadeInfo.target.global_position.y)
		
		positionB.x += -250
		positionC.x += -400
		
	elif grenadeInfo.projectileOwner.is_in_group("player"):
		enemyGroup = "enemy"
		
		set_collision_layer_bit(2, true)
		set_collision_mask_bit(1, true)
		set_collision_mask_bit(3, true)

		positionA = grenadeInfo.position
		positionB = Vector2(grenadeInfo.position.x + initialLenght, grenadeInfo.position.y - initialLenght)
		positionC = Vector2(grenadeInfo.position.x + fallLenght, grenadeInfo.position.y)
		
		positionB.x += 125
		positionC.x += 250


func _process(delta):
	air_elapsed_time += delta
	var t = null
	if enemyGroup == "enemy":
		t = range_lerp(air_elapsed_time, 0.0, air_duration, 0.0, 1.2)
	else:
		t = range_lerp(air_elapsed_time, 0.0, air_duration, 0.0, 0.5)
	
	var q0 = positionA.linear_interpolate(positionB, t)
	var q1 = positionB.linear_interpolate(positionC, t)
	global_position = q0.linear_interpolate(q1, t)
	$AnimatedSprite.rotate(0.1)
	
func OnBodyEntered(body):
	if enemies.has(body):
		return
		
	enemies.push_back(body)
	Boom()

func Boom():
	$AnimatedSprite.rotation_degrees = 0
	$AnimatedSprite.scale = Vector2(0.25,0.25)
	$AnimatedSprite.play("explode")
	set_process(false)
	
	for body in enemies:
		if is_instance_valid(body):
			if body.is_in_group(enemyGroup):
				if body.has_method("TakeDamage"):
					body.TakeDamage(Damage)
			
func AnimationFinished():
	if $AnimatedSprite.animation == "explode":
		queue_free()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Grenade_area_entered(area):
	if enemies.has(area):
		return
		
	enemies.push_back(area)
	Boom()
