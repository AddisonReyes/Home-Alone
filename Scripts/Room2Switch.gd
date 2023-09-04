extends Node3D


@onready var switch1 = $Switch8
@onready var switch2 = $Switch7


func _physics_process(delta):
	if switch1.interaction or switch2.interaction:
		$Lamp23.interact()
		$Lamp24.interact()
		
		switch1.interaction = false
		switch2.interaction = false
