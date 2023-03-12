extends Node2D

func _ready():
	$Timer.start()
	$AudioStreamPlayer.play()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_game()
	
func start_game():
	get_tree().change_scene("res://Levels/TestLevel.tscn")

func _on_Timer_timeout():
	$Play.visible = true
	$Exit.visible = true
	$Background.texture = load("res://Assets/Backgrounds/StartScreen.png")

func _on_Play_pressed():
	start_game()
	
func _on_Exit_pressed():
	get_tree().quit()



