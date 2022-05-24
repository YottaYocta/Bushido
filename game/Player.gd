extends KinematicBody

enum PLAYER_STATE {
	MOVEMENT,
	DASH,
	DIE
}

var state: int = PLAYER_STATE.MOVEMENT
var velocity := Vector3.ZERO
var dash_dir := Vector3.RIGHT
export var gravity := 10.0
export var acceleration := 7.0
export var dash_multiplier := 400.0
export var friction_coefficient := 10.0
export var vector_threshold := 0.1

func _ready():
	$AnimatedSprite3D.animation = 'idle'

func _process(delta):
	if state == PLAYER_STATE.MOVEMENT:
		if Input.is_action_just_pressed('dash'):
			$AnimatedSprite3D.animation = 'dash'
			velocity += dash_dir.rotated(Vector3.UP, rotation.y) * dash_multiplier * delta
			state = PLAYER_STATE.DASH
		else:
			var direction := Vector3.ZERO
			if Input.is_action_pressed('left'):
				direction.x -= 1
			if Input.is_action_pressed('right'):
				direction.x += 1
			if Input.is_action_pressed('forward'):
				direction.z -= 1
			if Input.is_action_pressed('backward'):
				direction.z += 1
			
			# Animation

			if velocity.length() < vector_threshold:
				$AnimatedSprite3D.animation = 'idle'
				velocity = Vector3.ZERO
			if velocity.length() > vector_threshold:
				$AnimatedSprite3D.animation = 'run'
				$AnimatedSprite3D.play()
			if direction.length() > vector_threshold:
				dash_dir = direction.normalized()

			if velocity.x < -vector_threshold:
				$AnimatedSprite3D.flip_h = true
			elif velocity.x > vector_threshold:
				$AnimatedSprite3D.flip_h = false
			
			direction = direction.rotated(Vector3.UP, rotation.y) * acceleration
			velocity += direction * delta;


	elif state == PLAYER_STATE.DASH:
		if velocity.length() < vector_threshold:
			state = PLAYER_STATE.MOVEMENT

	velocity -= velocity / friction_coefficient + Vector3(0, gravity, 0) * delta
	velocity = move_and_slide(velocity, Vector3.UP)

func kill():
	transform.origin = Vector3.ZERO + Vector3(0, 1, 0)
