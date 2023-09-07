extends Node3D


@onready var player = get_parent().get_parent().get_parent().get_node("Player")


func interact():
	player.flashlightPicked = true
	self.queue_free()
