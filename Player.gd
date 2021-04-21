extends RigidBody2D

export var rotate_speed: float = 0.1 
export var dash_speed: float = 200
export var dash_distance: int = 100

onready var sword_pivot = $SwordPivot

var is_dashing = false
var direction = Vector2.ZERO
var target_position = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if (!is_dashing):
		if (Input.is_action_pressed("rotate_left")):
			sword_pivot.rotate(-rotate_speed)
		if (Input.is_action_pressed("rotate_right")):
			sword_pivot.rotate(rotate_speed)
			
		if (Input.is_action_just_pressed("dash")):
			direction = Vector2.RIGHT.rotated(sword_pivot.rotation + rotation).normalized()
			apply_impulse(Vector2.ZERO, direction * dash_speed)
			
#			target_position = Vector2.ZERO
#	else:
#		var adjusted_speed = 10 
		#var velocity = move_and_slide(direction * dash_speed)
