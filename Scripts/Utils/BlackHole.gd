extends Node2D

export(float) var min_force = 60
export(float) var max_force = 250
export(float) var radius = 150 setget set_radius
var bodies_inside = []

func _ready():
	$LifeSpan.connect("timeout", self, "queue_free")
	$LifeSpan.start()
	$AnimatedSprite.play("default")
	$AnimatedSprite2.play("default")

func _draw():
	var pos = $AnimatedSprite.position
	pos.y += 30
	draw_circle(pos, radius, Color(0,0,0, 0.1))

func _process(delta):
	for hero in bodies_inside:
		var d = position.distance_to(hero.position)
		var force = range_lerp(d, 0, $Area2D/CollisionShape2D.shape.radius, max_force, min_force)
		var dir = position - hero.position
		var velocity = dir.normalized() * force * delta
		if velocity.length() < d:
			hero.position += velocity
			
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		bodies_inside.push_back(body)

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		bodies_inside.erase(body)

func set_radius(r):
	radius = r
	$Area2D/CollisionShape2D.shape.radius = r
