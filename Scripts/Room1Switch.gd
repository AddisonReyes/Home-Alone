extends Node3D

@onready var switch1 = $Switch6

func _physics_process(delta):
	if switch1.interaction:
		$Lamp9.interact()
		$Lamp10.interact()
		$Lamp13.interact()
		$Lamp14.interact()
		$Lamp15.interact()
		
		switch1.interaction = false
