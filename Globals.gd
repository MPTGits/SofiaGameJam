extends Node

onready var OnHit = preload("res://Animations/HitAnim.tscn")
onready var BLACKHOLE = preload("res://Utils/BlackHole/BlackHole.tscn")

signal BuyItem(price)

var money = 500

var terrains = [
	preload("res://Terrains/Terrain1.tscn"),
	preload("res://Terrains/Terrain2.tscn"),
	preload("res://Terrains/Terrain3.tscn"),
	preload("res://Terrains/Terrain4.tscn")
]

func CreateExplosionAnim(position, name):
	var explosion = OnHit.instance()
	explosion.set_as_toplevel(true)
	explosion.position = position
	explosion.position.x += rand_range(-5, 5)
	explosion.position.y += rand_range(-5, 5)
	explosion.init(name)
	
	get_tree().get_root().add_child(explosion)
	
func CreateBlackHole():
	randomize()
	
	var blackHole = BLACKHOLE.instance()
	blackHole.set_as_toplevel(true)
	get_tree().get_root().add_child(blackHole)
	
	var pos = get_tree().get_root().get_node("TestLevel").get_node("Camera2D").global_position
	var randX = rand_range(600.0, 1300.0)
	var randY = rand_range(200.0, 800.0)
	pos += Vector2(randX, randY)

	blackHole.global_position = pos
	


