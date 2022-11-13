"""
Implements the collision functionality of the map.
"""
extends Node



# We keep track of the collision shape of the map with a 2D Array.
# The elements are boolean with `true = solid` and `false = air`
var collision := {}

# Initialize the collision Array (with the noise line generated in $Map)
func init_map(col_dict: Dictionary) -> void:
	collision = col_dict 

# Returns the surface normal for a position
func collision_normal(pos: Vector2) -> Vector2:
	if is_in_collision(pos):
		return Vector2.ONE
	var normal := Vector2.ZERO
	for direction in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]:
		# Check the 4 pixels directly adjecent.
		var observed_pixel = pos + direction
		if (observed_pixel.x < 0		  # Left edge
			or observed_pixel.y < 0		  # Top edge
			or is_in_collision(observed_pixel)): # Solid terrain
			normal += direction * -1 # Point the normal the opposite way
	return normal.normalized() # Normalize the normal

func is_in_collision(pos: Vector2):
	if collision.has(pos.x):
		if collision[pos.x].has(pos.y):
			return true
	return false
	
func remove_sprite_from_collision(pos: Vector2):
	if collision.has(pos.x):
		if collision[pos.x].has(pos.y):
			print('removing '+ str(int(pos.x))+" | "+str(int(pos.y)))
		collision[pos.x].erase(pos.y)
	
# Create a circle-shaped hole at the position
func explosion(pos: Vector2, radius: int) -> void:
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			# We're looping over a square
			if Vector2(x, y).length() > radius:
				# Filter out when we're too far from the center
				continue
			var pixel = Vector2(int(pos.x), int(pos.y)) + Vector2(int(x),int(y)) # Move the circle to `pos`
			remove_sprite_from_collision(pixel)
