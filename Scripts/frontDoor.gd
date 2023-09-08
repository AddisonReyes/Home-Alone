extends Node3D
class_name FrontDoor

@onready var player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
@onready var pivot = get_parent().get_parent().get_node("Pivot")

var rng = RandomNumberGenerator.new()

var interactionCooldown = true
var playerSurvived = false

var locked = true
var keys = 0


func interact():
	if interactionCooldown:
		if locked and player.keys == 0:
			$Locked.play()
		
		elif locked and player.keys >= 1:
			keys += 1
			player.keys -= 1
		
		elif locked == false:
			$Open.play()
			
			playerSurvived = true
		
		interactionCooldown = false
		$Timer.start()


func _physics_process(delta):
	if keys >= 2:
		locked = false
	
	if keys == 1:
		$keys/Key1.visible = true
	
	if keys == 2:
		$keys/Key2.visible = true


func _on_timer_timeout():
	interactionCooldown = true


func _on_turn_off_timer_timeout():
	interact()
