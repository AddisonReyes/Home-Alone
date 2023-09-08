extends Node3D

@onready var switch1 = $Switch2
@onready var switch2 = $Switch3

func _physics_process(delta):
	if switch1.interaction or switch2.interaction:
		$Lamp3.interact()
		$Lamp4.interact()
		$Lamp5.interact()
		
		switch1.interaction = false
		switch2.interaction = false
