"""
This Script manages the map/terrain.
"""
extends Node2D

onready var fg = $FG
onready var bg = $BG

const TRANSPARENT := Color(0,0,0,0)

#  Save the initial ground height
var line := []
var no_collision_pixels := []

func _ready() -> void:
	randomize()		# Generate a new random seed
	_generate_map() # Generate a "map"
	print('init_map')
	$Collision.init_map(no_collision_pixels) # Initialize the "map" for collision

# Returns the surface normal for a position
func collision_normal(pos: Vector2) -> Vector2:
	return $Collision.collision_normal(pos) # $Collision implements this

# Generates a random map
func _generate_map() -> void:
	# Get the texture data and lock it (to allow editing)
	var fg_data = fg.texture.get_data()
	fg_data.lock()
	var bg_data = bg.texture.get_data()
	bg_data.lock()
	var x_max = fg_data.get_width()
	var y_max = fg_data.get_height()
	for x in range(x_max):
		var x_array = []
		for _index in range(x_max):
			x_array.append(true)
		for y in range(y_max):
			if fg_data.get_pixel(x,y) == TRANSPARENT:
				x_array[y] = false
		no_collision_pixels.append(x_array)
	fg_data.unlock() # Unlock the data since we're done with editing it
	bg_data.unlock() # Unlock the data since we're done with editing it


# Create a circle-shaped hole at the position
func explosion(pos: Vector2, radius: int) -> void:
	$Collision.explosion(pos, radius) # Tell the collision map to explode, too
	# Get and lock the graphics
	var fg_data = fg.texture.get_data()
	fg_data.lock()
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			# Loop over a square shape
			if Vector2(x, y).length() > radius:
				# Filter out the corners to leave the circle in the middle
				continue
			var pixel = pos + Vector2(x,y) # Move the circle to `pos`
			if pixel.x < 0 or pixel.x >= fg_data.get_width():
				continue # Outside the map
			if pixel.y < 0 or pixel.y >= fg_data.get_height():
				continue # Outside the map
			fg_data.set_pixelv(pixel, TRANSPARENT) # Set pixel transparent
	radius -= 10  # Use a smaller radius for the hole in the background
	# The rest is the same as for the foreground
	var bg_data = bg.texture.get_data()
	bg_data.lock()
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			# Loop over a square shape
			if Vector2(x, y).length() > radius:
				# Filter out the corners to leave the circle in the middle
				continue
			var pixel = pos + Vector2(x,y) # Move the circle to `pos`
			if pixel.x < 0 or pixel.x >= bg_data.get_width():
				continue # Outside the map
			if pixel.y < 0 or pixel.y >= bg_data.get_height():
				continue # Outside the map
			bg_data.set_pixelv(pixel, TRANSPARENT) # Set pixel transparent
	# Lock the graphics and use them
	fg_data.unlock()
	fg.texture.set_data(fg_data)
	bg_data.unlock()
	bg.texture.set_data(bg_data)
