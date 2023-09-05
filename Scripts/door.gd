extends Node3D
class_name Door

@onready var pivot = get_parent().get_parent().get_node("Pivot")
@onready var Area = $Area3D

var rng = RandomNumberGenerator.new()

var interactionCooldown = true
var checkBodies = false
var open = false


func interact():
	if interactionCooldown:
		if open:
			interactionCooldown = false
			pivot.rotation.y = 0
			$Timer.start()
			open = false
		
		else:
			interactionCooldown = false
			pivot.rotation.y = 89.45
			$Timer.start()
			open = true
	
	if open:
		var time = rng.randi_range(120, 300)
		$TurnOffTimer.wait_time = time
		$TurnOffTimer.start()


func _on_timer_timeout():
	interactionCooldown = true


func _on_turn_off_timer_timeout():
	interact()
