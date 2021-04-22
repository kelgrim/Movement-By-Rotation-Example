extends KinematicBody2D


export var rotate_speed: float = 0.1 

# Tweak these to to make the dash feel different
export var dash_distance: int = 300
export var max_speed = 500
export var min_speed = 100
export var lerp_percentage = 0.6
export var lerp_multiplier = 5

var target_position = Vector2.ZERO
var is_dashing = false

onready var sword_pivot = $SwordPivot

func _physics_process(delta):
	# if the player is not dashing, he can rotate the weapon and start a dash
	if !is_dashing:
		if (Input.is_action_pressed("rotate_left")):
			sword_pivot.rotate(-rotate_speed)
		if (Input.is_action_pressed("rotate_right")):
			sword_pivot.rotate(rotate_speed)
		
		if (Input.is_action_just_pressed("dash")):
			is_dashing = true
			var direction = Vector2.RIGHT.rotated(sword_pivot.rotation + rotation).normalized()
			target_position = global_position + direction * dash_distance
	
	# if the player is dashing, we only do movement	
	if is_dashing:
		var direction = global_position.direction_to(target_position)
		
		# Get the position that is between the character and the target position at x% of the way
		var lerped_pos = lerp(global_position, target_position, lerp_percentage)
		
		# Use the distance between the current position and lerped position as a way determine speed. 
		# (Basically, the closer you get to the target, the lower the lerped_speed will be)
		var lerped_speed = global_position.distance_to(lerped_pos) * lerp_multiplier
		
		# I make sure that the lerped speed doesn't get too high or too low
		var dash_speed = clamp(lerped_speed, min_speed, max_speed)
		
		# And then I do the actual move. 
		move_and_slide(direction.normalized() * dash_speed)
		
		var slide_count = get_slide_count()
		if slide_count > 0 || global_position.distance_to(target_position) < 20:
			is_dashing = false
			
		
