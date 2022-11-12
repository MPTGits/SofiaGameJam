extends AnimatedSprite

func _ready():
	connect("animation_finished", self, "queue_free")
	randomize()
	

func init(anim_name):
	scale.x *= rand_range(0.85, 1.15)
	scale.y *= rand_range(0.85, 1.15)
	speed_scale = rand_range(0.9, 1.1)
	
	if anim_name == "explosion":
		scale = Vector2(0.1,0.1)
		
	play(anim_name)
