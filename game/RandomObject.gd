extends StaticBody

func _ready():
	randomize()
	$AnimatedSprite3D.frame = randi() % $AnimatedSprite3D.frames.get_frame_count('default')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
