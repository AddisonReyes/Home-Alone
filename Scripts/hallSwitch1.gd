extends Node3D

@onready var switch = $Switch

func _physics_process(delta):
	if switch.interaction:
		$Lamp2.interact()
		$Lamp5.interact()
		$Lamp6.interact()
		$Lamp7.interact()
		
		switch.interaction = false
