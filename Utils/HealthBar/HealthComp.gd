extends Control

signal OnDead

onready var healthOver = $HealthOver
onready var healthUnder = $HealthUnder

export (float) var max_health = 100.0
var currentHealth = max_health

export (Color) var healthyColor = Color.green
export (Color) var cautionColor = Color.yellow
export (Color) var dangerColor = Color.red

export (float, 0, 1, 0.05) var cautionZone = 0.5
export (float, 0, 1, 0.05) var dangerZone = 0.25

var isDead = false

func GetCurrentHealth():
	return healthOver.value
		
func _physics_process(_delta):
#	currentHealth += (bodyStats.HealthRegenPerSec.Value * delta)
	currentHealth = min(currentHealth, max_health)
	
	healthOver.value = currentHealth / max_health
	healthUnder.value = lerp(healthUnder.value, healthOver.value, 0.05)
	RefreshHealthColor()
	
func TakeDamage(damage):
#	var bodyStats = get_parent().bodyStats
#	damage *= (1.0 - bodyStats.DamageReduction.Value)
	currentHealth = currentHealth - damage
	
	if currentHealth <= 0:
		isDead = true
		set_physics_process(false)
		emit_signal("OnDead")
		hide()
	else:
		RefreshHealthColor()
	
func RefreshHealthColor():
	if currentHealth < max_health * dangerZone:
		healthOver.tint_progress = dangerColor
	elif currentHealth < max_health * cautionZone:
		healthOver.tint_progress = cautionColor
	else:
		healthOver.tint_progress = healthyColor
