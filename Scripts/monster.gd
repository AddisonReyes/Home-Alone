extends CharacterBody3D


@onready var navAgent = $NavigationAgent3D

var SPEED = 4


func _physics_process(delta):
	var currentLocation = global_transform.origin
	var nextLocation = navAgent.get_next_path_position()
	var newVelocity = (nextLocation - currentLocation).normalized() * SPEED
	
	velocity = velocity.move_toward(newVelocity, .26)
	move_and_slide()


func update_target_location(target_location):
	navAgent.target_position = target_location


func _on_navigation_agent_3d_target_reached():
	print("BOO")
