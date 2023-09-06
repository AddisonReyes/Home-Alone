extends Node3D
class_name FrontDoor

@onready var pivot = get_parent().get_parent().get_node("Pivot")

var rng = RandomNumberGenerator.new()

var interactionCooldown = true

var locked = true


func interact():
	if interactionCooldown:
		if locked:
			$Locked.play()
		
		else:
			pass
		
		interactionCooldown = false
		$Timer.start()


func _on_timer_timeout():
	interactionCooldown = true


func _on_turn_off_timer_timeout():
	interact()
