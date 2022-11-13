extends Control

var healthBarStates = ["res://Assets/User Interface/EnergyBar/0.png",
					"res://Assets/User Interface/EnergyBar/1.png",
					"res://Assets/User Interface/EnergyBar/2.png",
					"res://Assets/User Interface/EnergyBar/3.png",
					"res://Assets/User Interface/EnergyBar/4.png",
					"res://Assets/User Interface/EnergyBar/5.png",
					"res://Assets/User Interface/EnergyBar/6.png",
					"res://Assets/User Interface/EnergyBar/7.png",
					"res://Assets/User Interface/EnergyBar/8.png",
					"res://Assets/User Interface/EnergyBar/9.png"]

signal OnDead

export (float) var max_health = 100.0
var currentHealth = max_health

func _physics_process(_delta):
	currentHealth = min(currentHealth, max_health)
	
	RefreshEnergySprite()
	
func TakeBoost(damage):
	currentHealth = currentHealth - damage
	
	var tween = get_tree().create_tween()
	tween.tween_property($TextureRect, "modulate", Color.black, 0.15)
	tween.tween_property($TextureRect, "modulate", Color.white, 0.15)
	tween.play()

	if currentHealth <= 10:
		currentHealth = 0
		set_physics_process(false)
		get_tree().change_scene("res://Levels/WinState.tscn")
		RefreshEnergySprite()
	
func RefreshEnergySprite():
	var index = int(currentHealth / 10 - 1)
	if index < 0:
		index = 0
	$TextureRect.texture = load(healthBarStates[index])
