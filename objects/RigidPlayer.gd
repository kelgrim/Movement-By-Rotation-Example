extends RigidBody2D

export var rotate_speed: float = 0.1 
export var dash_speed: float = 200

onready var sword_pivot = $SwordPivot

func _physics_process(delta):

	if (Input.is_action_pressed("rotate_left")):
		sword_pivot.rotate(-rotate_speed)
	if (Input.is_action_pressed("rotate_right")):
		sword_pivot.rotate(rotate_speed)
		
	if (Input.is_action_just_pressed("dash")):
		var direction = Vector2.RIGHT.rotated(sword_pivot.rotation + rotation).normalized()
		apply_impulse(Vector2.ZERO, direction * dash_speed)
			
