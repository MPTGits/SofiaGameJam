extends Node2D

func _ready():
	var terrain = Globals.terrains[0].instance()
	add_child(terrain)



