extends Area2D

onready var OnHit = preload("res://Animations/HitAnim.tscn")
var speed = 0
export var Damage = 20
var attackType = ""

func _ready():
	randomize()
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
	
	
func Init(pos, owner, typeAttack, Speed, toRight = true):
	CreateExplosionAnim(pos, "shooting")
	position = pos
	attackType = typeAttack
	speed = Speed
	
	if false == toRight:
		speed = -speed
		$Sprite.flip_h = true
		$CollisionShape2D.position.x *= (-1)
		$HitPosition.position.x *= (-1)
		
	if attackType == "zigzag":
		$Sprite.flip_h = false
		
	if owner.is_in_group("enemy"):
		set_collision_layer_bit(3, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(4, true)
	elif owner.is_in_group("player"):
		set_collision_layer_bit(2, true)
		set_collision_mask_bit(1, true)
		set_collision_mask_bit(3, true)
	
func CreateExplosionAnim(position, name):
	var explosion = OnHit.instance()
	explosion.position = position
	explosion.position.x += rand_range(-5, 5)
	explosion.position.y += rand_range(-5, 5)
	explosion.init(name)
	
	get_tree().get_root().add_child(explosion)

func _on_RocketProjectile_body_entered(body):
	body.TakeDamage(Damage)
	
	CreateExplosionAnim($HitPosition.global_position, "hit")
	
	queue_free()
