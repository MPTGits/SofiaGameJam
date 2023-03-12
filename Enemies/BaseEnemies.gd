extends KinematicBody2D

var player = null
var health = 100
var attackInfo : ProjectileInfo = ProjectileInfo.new()

export(String, "grenade", "zigzag", "normal") var attackType = "zigzag"
var attackProjectiles = { "grenade": preload("res://Projectiles/Grenade.tscn"),
						  "zigzag": preload("res://Projectiles/RocketProjectile.tscn"),
						  "normal": preload("res://Projectiles/RocketProjectile.tscn") }

func _ready():
	randomize()
	attackInfo.projectileOwner = self
	attackInfo.attackType = attackType
	attackInfo.flippedSprite = $Sprite.flip_h
	attackInfo.position = $Position2D.global_position
 
func _on_AttackTimer_timeout():
	if player == null:
		return
		
	attackInfo.target = player
	
	var projectile = attackProjectiles.get(attackType).instance()
	get_tree().get_root().add_child(projectile)
	projectile.Init(attackInfo)
	
	$AttackTimer.wait_time = rand_range(0.7, 1.2)
	$AttackTimer.start()

func _on_Area2D_body_entered(body):
	$AttackTimer.start()
	player = body

func _on_AttackArea_body_exited(_body):
	player = null
	
func TakeDamage(damage):
	health -= damage
	if health <= 0:
		queue_free()
