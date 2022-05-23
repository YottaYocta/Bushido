extends Spatial

var velocity := Vector3()
export var acceleration := 1.0
export var dash_multiplier := 6.0
export var friction_coefficient := 5.0

func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed('ui_left'):
		velocity.x -= acceleration / 100
	if Input.is_action_pressed('ui_right'):
		velocity.x += acceleration / 100
	if Input.is_action_pressed('ui_up'):
		velocity.z -= acceleration / 100
	if Input.is_action_pressed('ui_down'):
		velocity.z += acceleration / 100
	if Input.is_action_just_pressed('jump'):
		velocity = velocity.normalized() * dash_multiplier 

	velocity -= velocity / friction_coefficient
	if velocity.length() < 0.01:
		$AnimatedSprite3D.stop()
	transform.origin += (velocity * delta).rotated(Vector3.UP, deg2rad(rotation_degrees.y))
	if velocity.length() > 0.01:
		$AnimatedSprite3D.play()


	# Animation

	if velocity.x < -0.01:
		$AnimatedSprite3D.flip_h = true
	elif velocity.x > 0.01:
		$AnimatedSprite3D.flip_h = false

		
