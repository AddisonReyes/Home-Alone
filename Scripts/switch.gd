extends Node3D


var buttonOn = true
var interaction = false

var canInteract = true


func interact():
	if canInteract:
		interaction = true
		
		if buttonOn:
			$Buttom2.visible = true
			$Buttom.visible = false
			buttonOn = false
		
		else:
			$Buttom2.visible = false
			$Buttom.visible = true
			buttonOn = true
		
		$Timer.start()
		canInteract = false


func _on_timer_timeout():
	canInteract = true
