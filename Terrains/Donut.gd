extends Node2D

var rot = 0.0
var speed = 5

func _process(delta):
	rot += delta * speed
	
	$Sprite.rotation_degrees = rot
	$Sprite2.rotation_degrees = rot
	
	if rot >= 5.0:
		speed *= -1
	if rot <= -5.0:
		speed *= -1
		
