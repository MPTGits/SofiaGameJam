extends Node2D

var CorrectSound = preload("res://Assets/Sound/music1.wav")
onready var play_again:TextureButton = $Play


# Called when the node enters the scene tree for the first time.
func _ready():
	play_again.connect("pressed", self, "load_play")
	
	
func load_play():
	get_tree().change_scene("res://Levels/TestLevel.tscn")
		

func _process(delta):
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = CorrectSound
		$AudioStreamPlayer.play()
	


