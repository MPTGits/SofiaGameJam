extends Node2D

onready var fg = $FG
onready var fg2 = $FG2

const TRANSPARENT := Color(0,0,0,0)

var line := []
var collision_pixels := {}
var destructible_sprites := []

func _on_VisibilityNotifier2D_screen_entered():
	var index = randi() % Globals.terrains.size()
	var terrain = Globals.terrains[index].instance()
	get_parent().add_child(terrain)
	terrain.global_position.x = $Position2D.global_position.x

func _on_DeleteTerrain_screen_exited():
	queue_free() 


func _ready() -> void:
	destructible_sprites = [fg, fg2]
	_generate_map() # Generate a "map"
	print('init_map')
	$Collision.init_map(collision_pixels) # Initialize the "map" for collision

# Returns the surface normal for a position
func collision_normal(pos: Vector2) -> Vector2:
	return $Collision.collision_normal(pos) # $Collision implements this

# Generates a random map
func _generate_map() -> void:
	var counter = 0
	for destro in destructible_sprites:
		counter+= 1
		print('generate map - '+str(destro))
		for pixel in destro.global_collision_grid_part:
			var p = Vector2(int(pixel.x), int(pixel.y))
			if counter == 3:
				print('this one: '+ str(p))
				counter += 1
			if not collision_pixels.has(p):
				if p.x in collision_pixels:
					collision_pixels[p.x].append(p.y)
				else:
					collision_pixels[p.x] = [p.y]

# Create a circle-shaped hole at the position
func explosion(pos: Vector2, radius: int) -> void:
	pos = Vector2(int(pos.x), int(pos.y))
	for destro in destructible_sprites:
		destro.erase_at_pos(pos, radius)
	if pos.x in collision_pixels:
		collision_pixels[pos.x].erase(pos.y)
