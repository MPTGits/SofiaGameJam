extends AnimatedSprite

var boostItem: String
var boostRelocated: bool = false;
var new_y_pos: int;
var new_x_pos: int;

# Called when the node enters the scene tree for the first time.
func _ready():
	boostItem = 'defaultMonster' if randf() <= 0.5 else 'defaultCoffe'
	

func _process(delta):
	if randf() <= 0.5:
		play(boostItem)
	else:
		self.hide()

