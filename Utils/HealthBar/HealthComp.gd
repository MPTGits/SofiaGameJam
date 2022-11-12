extends Control

var healthBarStates = ["res://Assets/User Interface/HealthBar/0.png",
					"res://Assets/User Interface/HealthBar/1.png",
					"res://Assets/User Interface/HealthBar/2.png",
					"res://Assets/User Interface/HealthBar/3.png",
					"res://Assets/User Interface/HealthBar/4.png",
					"res://Assets/User Interface/HealthBar/5.png",
					"res://Assets/User Interface/HealthBar/6.png",
					"res://Assets/User Interface/HealthBar/7.png",
					"res://Assets/User Interface/HealthBar/8.png",
					"res://Assets/User Interface/HealthBar/9.png"]

signal OnDead

export (float) var max_health = 100.0
var currentHealth = max_health

func _physics_process(_delta):
	currentHealth = min(currentHealth, max_health)
	
	RefreshHealthSprite()
	
func TakeDamage(damage):
	currentHealth = currentHealth - damage
	
	var tween = get_tree().create_tween()
	tween.tween_property($TextureRect, "modulate", Color.black, 0.15)
	tween.tween_property($TextureRect, "modulate", Color.white, 0.15)
	tween.play()

	if currentHealth <= 0:
		currentHealth = 0
		set_physics_process(false)
		emit_signal("OnDead")
		RefreshHealthSprite()
	
func RefreshHealthSprite():
	var index = int(currentHealth / 10 - 1)
	if index < 0:
		index = 0
	$TextureRect.texture = load(healthBarStates[index])
