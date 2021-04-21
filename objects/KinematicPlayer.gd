extends KinematicBody2D


export var rotate_speed: float = 0.1 
export var dash_speed: float = 400
export var dash_distance: int = 300
var target_position = Vector2.ZERO
var is_dashing = false


onready var sword_pivot = $SwordPivot

func _ready():
	pass # Replace with function body.

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
	
	# if the player is dashing, we only check if he is getting 		
	if is_dashing:
		var direction = global_position.direction_to(target_position)
		move_and_slide(direction.normalized() * dash_speed)
		
		var slide_count = get_slide_count()
		if slide_count > 0 || global_position.distance_to(target_position) < 20:
			is_dashing = false
			
		
