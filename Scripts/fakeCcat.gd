extends CharacterBody3D


const monsterPath = preload("res://Scenes/monster.tscn")
@onready var navAgent = $NavigationAgent3D

var stayQuiet = false
var SPEED = 4.06


func _physics_process(delta):	
	if stayQuiet:
		return
	
	$AnimationPlayer.play("walk")
	var currentLocation = global_transform.origin
	var nextLocation = navAgent.get_next_path_position()
	var newVelocity = (nextLocation - currentLocation).normalized() * SPEED
		
	velocity = velocity.move_toward(newVelocity, .26)
	look_at(nextLocation)
	move_and_slide()


func spawnMonster():
	var monster = monsterPath.instantiate()
	monster.position = self.position
	get_parent().add_child(monster)
	get_parent().monsterSpawned()
	self.queue_free()


func interact():
	spawnMonster()


func idle():
	$AnimationPlayer.play("idle")
	stayQuiet = true


func chase():
	stayQuiet = false


func update_target_location(target_location):
	navAgent.target_position = target_location


func _on_navigation_agent_3d_target_reached():
	idle()
