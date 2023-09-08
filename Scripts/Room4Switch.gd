extends Node3D


@onready var switch1 = $Switch17
@onready var switch2 = $Switch18


func _physics_process(delta):
	if switch1.interaction or switch2.interaction:
		$Lamp33.interact()
		$Lamp34.interact()
		$Lamp35.interact()
		
		switch1.interaction = false
		switch2.interaction = false
