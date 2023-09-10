extends Node3D


@onready var switch1 = $Switch15
@onready var switch2 = $Switch16
@onready var switch3 = $Switch17


func _physics_process(delta):
	if switch1.interaction or switch2.interaction or switch3.interaction:
		$Lamp32.interact()
		$Lamp33.interact()
		
		switch1.interaction = false
		switch2.interaction = false
		switch3.interaction = false
