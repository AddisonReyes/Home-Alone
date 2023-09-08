extends Node3D

@onready var switch1 = $Switch6
@onready var switch2 = $Switch5
@onready var switch3 = $Switch7

func _physics_process(delta):
	if switch1.interaction or switch2.interaction or switch3.interaction:
		$Lamp20.interact()
		$Lamp21.interact()
		$Lamp22.interact()
		$Lamp23.interact()
		
		switch1.interaction = false
		switch2.interaction = false
		switch3.interaction = false
