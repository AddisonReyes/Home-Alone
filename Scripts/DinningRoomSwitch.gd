extends Node3D

@onready var switch1 = $Switch11
@onready var switch2 = $Switch12
@onready var switch3 = $Switch13


func _physics_process(delta):
	if switch1.interaction or switch2.interaction or switch3.interaction:
		$Lamp28.interact()
		$Lamp29.interact()
		$Lamp30.interact()
		
		switch1.interaction = false
		switch2.interaction = false
		switch3.interaction = false
