extends Node2D

var CorrectSound = preload("res://Assets/Sound/music1.wav")
var start_screen = preload("res://Assets/Backgrounds/StartScreen.png")
onready var play_again:TextureButton = $Play


# Called when the node enters the scene tree for the first time.
func _ready():
	$Play.visible = false
	$Timer.start()
	play_again.connect("pressed", self, "load_play")
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		load_play()
	
func load_play():
	get_tree().change_scene("res://Levels/TestLevel.tscn")
		

func _process(delta):
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = CorrectSound
		$AudioStreamPlayer.play()
	




func _on_Timer_timeout():
	print("zaredih")
	$Background.texture = start_screen
	$Play.visible = true
