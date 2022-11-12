extends CanvasLayer

onready var HealthBar = $HealthComp

func _on_ShopBtn_pressed():
	get_tree().change_scene("res://Menus/Store.tscn")
