extends Node3D

@onready var switch1 = $Switch8

func _physics_process(delta):
	if switch1.interaction:
		$Lamp20.interact()
		$Lamp21.interact()
		
		switch1.interaction = false
