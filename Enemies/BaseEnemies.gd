extends KinematicBody2D

onready var GRENADE = preload("res://Projectiles/Grenade.tscn")
onready var BULLET = preload("res://Projectiles/RocketProjectile.tscn")

var enemy = null

export var Speed = 1000
export(String, "zigzag", "normal", "grenade") var attackType = "zigzag"

func _on_AttackTimer_timeout():
	if enemy == null:
		return
		
	if attackType == "grenade":
		var grenade = GRENADE.instance()
		grenade.set_as_toplevel(true)
		grenade.z_index = 10
		get_tree().get_root().add_child(grenade)
		grenade.Init($Position2D.global_position, true, self, enemy)
	else:
		var bullet = BULLET.instance()
		get_tree().get_root().add_child(bullet)
		bullet.Init($Position2D.global_position, self, attackType, Speed, false)
		bullet.attackType = attackType
	
	$AttackTimer.start()

func _on_Area2D_body_entered(body):
	$AttackTimer.start()
	enemy = body

func _on_AttackArea_body_exited(body):
	enemy = null
