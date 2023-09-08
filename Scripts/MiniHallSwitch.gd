extends Node3D

@onready var switch1 = $Switch14


func _physics_process(delta):
	if switch1.interaction:
		$Lamp31.interact()
		$Lamp32.interact()
		$Lamp33.interact()
		
		switch1.interaction = false
