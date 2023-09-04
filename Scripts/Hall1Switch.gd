extends Node3D

@onready var switch1 = $Switch6
@onready var switch2 = $Switch5

func _physics_process(delta):
	if switch1.interaction or switch2.interaction:
		$Lamp19.interact()
		
		switch1.interaction = false
		switch2.interaction = false
