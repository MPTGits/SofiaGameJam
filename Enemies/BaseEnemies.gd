extends KinematicBody2D

onready var BULLET = preload("res://Projectiles/RocketProjectile.tscn")

export var Speed = 1000
export(String, "zigzag", "normal") var attackType = "zigzag"

func _on_AttackTimer_timeout():
	var bullet = BULLET.instance()
	get_tree().get_root().add_child(bullet)
	bullet.Init($Position2D.global_position, self, attackType, Speed, false)
	bullet.attackType = attackType
	
	$AttackTimer.start()

func _on_Area2D_body_entered(_body):
	$AttackTimer.start()
