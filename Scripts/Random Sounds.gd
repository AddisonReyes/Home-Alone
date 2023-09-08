extends Node3D

@onready var Ouija = $Ouija

func _physics_process(delta):
	if Ouija.interaction:
		$s1.play()
		
		Ouija.interaction = false
