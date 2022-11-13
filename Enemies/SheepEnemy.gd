extends "res://Enemies/BaseEnemies.gd"

var offset = 0
var speed = 3

func _physics_process(delta):
	offset += delta * speed
	
	position.y += offset
	if offset >= 3.0:
		speed *= -1
	if offset <= -3.0:
		speed *= -1
	
