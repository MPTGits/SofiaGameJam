extends Node2D

var CorrectSound = preload("res://Assets/Sound/music2.wav")
var counter: int = 0
func _ready():
	var terrain = Globals.terrains[0].instance()
	add_child(terrain)
	
func _process(delta):
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = CorrectSound
		$AudioStreamPlayer.play()
	




