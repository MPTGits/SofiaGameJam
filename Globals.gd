extends Node

onready var OnHit = preload("res://Animations/HitAnim.tscn")

signal BuyItem(price)

var money = 500

var terrains = [
	preload("res://Terrains/Terrain1.tscn"),
	preload("res://Terrains/Terrain2.tscn"),
	preload("res://Terrains/Terrain3.tscn")
]

func CreateExplosionAnim(position, name):
	var explosion = OnHit.instance()
	explosion.set_as_toplevel(true)
	explosion.position = position
	explosion.position.x += rand_range(-5, 5)
	explosion.position.y += rand_range(-5, 5)
	explosion.init(name)
	
	get_tree().get_root().add_child(explosion)
