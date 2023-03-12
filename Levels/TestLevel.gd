extends Node2D

var counter: int = 0

func _ready():
	$AudioStreamPlayer.play()
	var terrain = Globals.terrains.front().instance()
	add_child(terrain)
	




