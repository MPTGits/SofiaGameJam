extends Node2D

var bilbords = ["res://Assets/Platform/Terrain/adv_1.png",
				"res://Assets/Platform/Terrain/adv_2.png",
				"res://Assets/Platform/Terrain/adv_3.png"]

func _ready():
	randomize()
	
	$Sprite.texture = load(bilbords[randi() % 3])
	
	var scaleRand = randi() % 3
	if scaleRand == 2:
		$Sprite.scale = Vector2(0.7, 0.7)
	elif scaleRand == 1:
		$Sprite.scale = Vector2(0.6, 0.6)
	else:
		$Sprite.scale = Vector2(0.5, 0.5)


