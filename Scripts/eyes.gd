extends Node3D

@onready var player = get_parent().get_parent().get_parent().get_node("Player")
@onready var pivot = $Pivot

func _physics_process(delta):
	pivot.look_at(player.position)
	
	if player.flashlightOn:
		self.hide()
		
	else:
		self.show()
