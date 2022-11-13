extends Sprite

export(Texture) var destr1
export(Texture) var destr2

var numOfHits = 0

func _on_Area2D_area_entered(area):
	numOfHits += 1
	if numOfHits == 2:
		texture = destr1
	elif numOfHits == 5:
		texture = destr2
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$StaticBody2D/CollisionPolygon2D.set_deferred("disabled", true)
		
