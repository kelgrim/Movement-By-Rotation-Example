extends KinematicBody2D


export var rotate_speed: float = 0.1 
#export var dash_speed: float = 400

export var dash_distance: int = 400
var target_position = Vector2.ZERO
var is_dashing = false

onready var tween = $Tween
onready var ray = $SwordPivot/RayCast2D
onready var sword_pivot = $SwordPivot

func _ready():
	ray.cast_to = Vector2(dash_distance,0)
	ray.enabled = true

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
			
			# Added a raycast. Because the tween will ignore collisions. So if the ray
			# detects a collision, it will return the point of the collision and we dash there. 
			if ray.is_colliding():
				target_position = ray.get_collision_point()
			else:
				target_position = global_position + direction * dash_distance
				
			# the distance can be somewhere between 0 and 400. 400 would take a second with this calculation
			var tween_time = global_position.distance_to(target_position) / 400
			tween.interpolate_property(self, "position", position, target_position, tween_time, Tween.TRANS_SINE, Tween.EASE_OUT)
			tween.start()
	
	# if the player is dashing, we only check if he is getting 		


#		var direction = global_position.direction_to(target_position)
#		move_and_slide(direction.normalized() * dash_speed)
#
#		var slide_count = get_slide_count()
#		if slide_count > 0 || global_position.distance_to(target_position) < 20:
#			is_dashing = false
			
		


func _on_Tween_tween_all_completed():
	print("tween completed")
	is_dashing = false
