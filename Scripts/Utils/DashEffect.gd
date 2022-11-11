extends Tween

export(int) var sprite_fades_count = 5
export(float) var fade_out_time = 2

export(NodePath) var sprite_owner
export(NodePath) var move_component

var count = 0

func _ready():
	if get_node(move_component).has_node("Dash"):
		get_node(move_component).get_node("Dash").connect("on_dash_begin", self, "on_dash_begin")
		get_node(move_component).get_node("Dash").connect("on_dash_end", self, "on_dash_end")

func on_dash_begin():
	$Timer.start()
	
func on_dash_end():
	$Timer.stop()
	count = 0
	
func _on_Timer_timeout():
	count += 1 
	if count > sprite_fades_count:
		return
	
	$Timer.start()
	
	var sprite = get_node(sprite_owner).duplicate()
	sprite.position = get_node(move_component).get_node("Dash").get_linear_pos()
	add_child(sprite)

	interpolate_property(sprite, "modulate:a", 1.0, 0.0, fade_out_time, Tween.TRANS_EXPO, Tween.EASE_OUT)
	start()
	
	yield(get_tree().create_timer(fade_out_time), "timeout")
	sprite.queue_free()
	
