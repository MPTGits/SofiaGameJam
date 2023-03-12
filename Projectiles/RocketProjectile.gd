extends Area2D

var speed = 1000
export var Damage = 10
var attackType = ""

func _ready():
	$VisibilityNotifier2D.connect("screen_exited", self, "queue_free")

func _process(delta):
	if attackType == "normal":
		position.x += speed * delta
	elif attackType == "zigzag":
		var next_pos = position
	
		next_pos.x += speed * delta
		next_pos.y += sin(next_pos.x * 0.009) * 10
		$Sprite.look_at(next_pos)
		position = next_pos
	
func Init(info: ProjectileInfo):
	Globals.CreateExplosionAnim(info.position, "shooting")
	position = info.position
	attackType = info.attackType
	
	if false == info.flippedSprite:
		speed = -speed
		$Sprite.flip_h = true
		$CollisionShape2D.position.x *= (-1)
		$HitPosition.position.x *= (-1)
		
	if attackType == "zigzag":
		$Sprite.flip_h = false
		
	if info.projectileOwner.is_in_group("enemy"):
		set_collision_layer_bit(3, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(4, true)
	elif info.projectileOwner.is_in_group("player"):
		set_collision_layer_bit(2, true)
		set_collision_mask_bit(1, true)
		set_collision_mask_bit(3, true)

func _on_RocketProjectile_body_entered(body):
	body.TakeDamage(Damage)
	
	Globals.CreateExplosionAnim($HitPosition.global_position, "hit")
	
	queue_free()
