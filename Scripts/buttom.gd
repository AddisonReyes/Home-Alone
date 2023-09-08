extends StaticBody3D


func interact():
	get_parent().interact()

func _process(delta):
	self.visible = get_parent().visible
