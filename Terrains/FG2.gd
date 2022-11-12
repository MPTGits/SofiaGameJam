extends Sprite
const TRANSPARENT := Color(0,0,0,0)
const IS_AT_BACK = 0

var collision_grid: Array
var global_collision_grid_part: Array
var scene_offset: Vector2 = self.get_global_position()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_sprite_pixels_to_collision()
	
func add_sprite_pixels_to_collision():
	var image_data = self.texture.get_data()
	image_data.lock()
	var x_max = image_data.get_width()
	var y_max = image_data.get_height()
	for x in range(x_max):
		for y in range(y_max):
			if image_data.get_pixel(x,y) != TRANSPARENT:
				collision_grid.append(Vector2(x, y))
				global_collision_grid_part.append(Vector2(scene_offset.x + x, scene_offset.y + y))
	image_data.unlock()
	
func erase_at_pos(global_pos:Vector2, radius:int):
	var pos = global_pos - scene_offset
	if IS_AT_BACK:
		radius -= 10
	$"../Collision".explosion(global_pos, radius) # Tell the collision map to explode, too
	# Get and lock the graphics
	var image_data = self.texture.get_data()
	image_data.lock()
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			# Loop over a square shape
			if Vector2(x, y).length() > radius:
				# Filter out the corners to leave the circle in the middle
				continue
			var pixel = pos + Vector2(x,y) # Move the circle to `pos`
			if pixel.x < 0 or pixel.x >= image_data.get_width():
				continue # Outside the map
			if pixel.y < 0 or pixel.y >= image_data.get_height():
				continue # Outside the map
			image_data.set_pixelv(pixel, TRANSPARENT) # Set pixel transparent
	# Lock the graphics and use them
	image_data.unlock()
	self.texture.set_data(image_data)
	
