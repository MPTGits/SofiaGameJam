extends CanvasLayer

onready var HealthBar = $HealthComp

func _on_Button_button_down():
	Globals.onFlyButtonPressed = true

func _on_Button_button_up():
	Globals.onFlyButtonPressed = false


func _on_ShopBtn_pressed():
	get_tree().change_scene("res://Menus/Store.tscn")
