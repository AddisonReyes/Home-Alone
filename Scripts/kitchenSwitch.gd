extends Node3D

@onready var switch1 = $Switch5
@onready var switch2 = $Switch4

func _physics_process(delta):
	if switch1.interaction or switch2.interaction:
		$Lamp5.interact()
		$Lamp8.interact()
		$Lamp6.interact()
		$Lamp7.interact()
		
		switch1.interaction = false
		switch2.interaction = false
