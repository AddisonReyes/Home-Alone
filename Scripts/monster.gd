extends CharacterBody3D
class_name Enemy

@onready var navAgent = $NavigationAgent3D

var SPEED = 3.85

var followPlayer = true
var state = "chase"


func _ready():
	$Timer.start()


func _physics_process(delta):
	if state == "Searching":
		pass
		
	if state == "chase" and followPlayer:
		var currentLocation = global_transform.origin
		var nextLocation = navAgent.get_next_path_position()
		var newVelocity = (nextLocation - currentLocation).normalized() * SPEED
		
		velocity = velocity.move_toward(newVelocity, .26)
		look_at(nextLocation)
		move_and_slide()
	
	if state == "Kill":
		pass


func interact_with_the_world():
	
	if $RayCast3D.is_colliding():
		print("OK")
		var collider = $RayCast3D.get_collider()
		
		if collider != null:
			if collider.is_in_group("interactable"):
				collider.interact()
			
			print(collider)
	
		


func update_target_location(target_location):
	navAgent.target_position = target_location


func _on_navigation_agent_3d_target_reached():
	pass #state = "Kill"


func _on_timer_timeout():
	interact_with_the_world()
	$Timer.start()
