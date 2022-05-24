extends Area

func _ready():
	pass

func _on_Deadzone_body_entered(body:Node):
	if body.has_method('kill'):
		body.kill()
