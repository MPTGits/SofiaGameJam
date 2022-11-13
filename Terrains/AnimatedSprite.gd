extends AnimatedSprite

var boostItem: String
var boostRelocated: bool = false;
var new_y_pos: int;
var new_x_pos: int;

# Called when the node enters the scene tree for the first time.
func _ready():
	boostItem = 'defaultMonster' if randf() <= 0.5 else 'defaultCoffe'
	

func _process(delta):
	play(boostItem)
	# Repositions the boost position dynamically changing x and y position
	if not (get_child(0).is_on_screen() or boostRelocated):
		boostRelocated = true
		new_y_pos = position.y + (randi() % 350)*[-1,1][randi() % 2]
		position.y = new_y_pos if new_y_pos < 900 else 900
		new_x_pos = position.x + (randi() % 250)*[-1,1][randi() % 2]
		position.x = new_x_pos if new_x_pos > 300 else 300
	if get_child(0).is_on_screen():
		boostRelocated = false

