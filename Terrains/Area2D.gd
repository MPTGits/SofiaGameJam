extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PlayerDetector_body_entered(body):
	var push_direction = 1 if body.moving_direction == 'right' else -1 
	body.position.x -= (body.accelaration * body.speed + 10)*push_direction
