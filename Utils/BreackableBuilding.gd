extends Sprite

onready var destr1 = preload("res://Assets/Platform/Buildings/asset-1-destr_A.png")
onready var destr2 = preload("res://Assets/Platform/Buildings/asset-1-destrB.png")

var numOfHits = 0

func _on_Area2D_area_entered(area):
	numOfHits += 1
	if numOfHits == 1:
		texture = destr1
	elif numOfHits == 2:
		texture = destr2
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
