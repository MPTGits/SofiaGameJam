extends Node2D

var CorrectSound = preload("res://Assets/Sound/music1.wav")
onready var back_to_start:TextureButton = $GoToStart
onready var play_again:TextureButton = $PlayAgain

# Called when the node enters the scene tree for the first time.
func _ready():
	back_to_start.connect("pressed", self, "load_start")
	play_again.connect("pressed", self, "load_play")
	
func load_play():
	get_tree().change_scene("res://Levels/TestLevel.tscn")
	
func load_start():
	get_tree().change_scene("res://Levels/StartScreen.tscn")
	
func _process(delta):
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = CorrectSound
		$AudioStreamPlayer2D.play()
