extends Node3D

@onready var player = get_parent().get_parent().get_parent().get_node("Player")


func interact():
	get_parent().get_parent().get_parent().killRealCat()
	player.purinePicked()
	self.queue_free()


func _physics_process(delta):
	$StaticBody3D.visible = player.myCatIsDeath
