extends Node3D

@onready var player = get_parent().get_parent().get_parent().get_node("Player")


func interact():
	if player.myCatIsDeath:
		player.doingNoise = true
		player.purinePicked()
		self.queue_free()


func _physics_process(delta):
	$StaticBody3D.visible = player.myCatIsDeath
