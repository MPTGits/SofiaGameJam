extends Node2D

func _on_VisibilityNotifier2D_screen_entered():
	var index = randi() % Globals.terrains.size()
	var terrain = Globals.terrains[index].instance()
	get_parent().add_child(terrain)
	terrain.global_position.x = $Position2D.global_position.x


func _on_DeleteTerrain_screen_exited():
	queue_free()
