extends Area2D

var boostItem: String
var boostLocated: bool = false;
var new_y_pos: int;
var new_x_pos: int;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	boostItem = 'defaultMonster' if randf() <= 0.5 else 'defaultCoffe'
	

func _process(delta):
	randomize()
	$AnimatedSprite.play(boostItem)
	if $AnimatedSprite/VisibilityNotifier2D.is_on_screen() and (not boostLocated):
		if randf() <= 0.5:
			$AnimatedSprite.show()
		else:
			$AnimatedSprite.hide()
		boostLocated = true
	if not $AnimatedSprite/VisibilityNotifier2D.is_on_screen():
		boostLocated = false



func _on_Node2D_body_entered(body):
	if $AnimatedSprite.is_visible_in_tree():
		body.TakeBoost(10)
	$AnimatedSprite.hide()
	
