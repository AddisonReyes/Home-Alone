extends Node3D

@onready var switch1 = $Switch19
@onready var switch2 = $Switch20


func _physics_process(delta):
	if switch1.interaction or switch2.interaction:
		$Lamp36.interact()
		$Lamp35.interact()
		$Lamp37.interact()
		
		switch1.interaction = false
		switch2.interaction = false
