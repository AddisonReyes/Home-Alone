extends Node3D


@onready var switch1 = $Switch9
@onready var switch2 = $Switch10


func _physics_process(delta):
	if switch1.interaction or switch2.interaction:
		$Lamp25.interact()
		$Lamp26.interact()
		
		switch1.interaction = false
		switch2.interaction = false
