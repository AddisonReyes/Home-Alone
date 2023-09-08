extends Node3D


@onready var player = get_parent().get_parent().get_parent().get_node("Player")


func interact():
	if self.visible:
		player.doingNoise = true
		player.addKey()
		
		self.queue_free()
