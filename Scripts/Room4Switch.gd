extends Node3D


@onready var switch1 = $Switch17
@onready var switch2 = $Switch18
@onready var switch3 = $Switch19


func _physics_process(delta):
	if switch1.interaction or switch2.interaction or switch3.interaction:
		$Lamp33.interact()
		$Lamp34.interact()
		$Lamp35.interact()
		
		switch1.interaction = false
		switch2.interaction = false
		switch3.interaction = false
