extends StaticBody

func _ready():
	var objects: AnimatedSprite3D = get_node_or_null('AnimatedSprite3D')
	if objects:
		randomize()
		objects.frame = randi() % objects.frames.get_frame_count('default')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
