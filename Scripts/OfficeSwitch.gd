extends Node3D

@onready var switch1 = $Switch6

func _physics_process(delta):
	if switch1.interaction:
		$Lamp15.interact()
		$Lamp17.interact()
		
		switch1.interaction = false
