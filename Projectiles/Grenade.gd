extends Area2D

var Damage = 80
var enemies = []

export(int) var height = 30
export(int) var initialLenght = 100
export(int) var fallLenght = 130

var positionA := Vector2()
var positionB := Vector2()
var positionC := Vector2()

var air_duration = 0.8
var air_elapsed_time = 0.0

func Init(firstPos, direction):
	$AnimatedSprite.play("default")
	positionA = firstPos
	positionA.y -= height
	positionB = Vector2(firstPos.x + initialLenght, firstPos.y - initialLenght)
	positionC = Vector2(firstPos.x + fallLenght, firstPos.y)
	
	if direction:
		positionB.x += -125
		positionC.x += -250
	else:
		positionB.x += 125
		positionC.x += 250

func _process(delta):
	air_elapsed_time += delta
	var t = range_lerp(air_elapsed_time, 0.0, air_duration, 0.0, 1.2)
	
	var q0 = positionA.linear_interpolate(positionB, t)
	var q1 = positionB.linear_interpolate(positionC, t)
	global_position = q0.linear_interpolate(q1, t)
	$AnimatedSprite.rotate(0.1)
	
func OnBodyEntered(body):
	if body.is_in_group("player"):
		return
	
	if body.is_in_group("enemy"):
		if body != get_parent():
			if enemies.has(body):
				return
			enemies.push_back(body)
			Boom()
	else:
		Boom()

func Boom():
	$AnimatedSprite.rotation_degrees = 0
	$AnimatedSprite.scale = Vector2(0.25,0.25)
	$AnimatedSprite.play("explode")
	set_process(false)
	for body in enemies:
		if body.is_in_group("enemy"):
			if is_instance_valid(body):
				if body.has_method("OnGotHit"):
					body.OnGotHit(Damage, Color(0.9, 0.55, 0.05))
			
func AnimationFinished():
	if $AnimatedSprite.animation == "explode":
		queue_free()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
