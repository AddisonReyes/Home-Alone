extends CharacterBody3D


var rng = RandomNumberGenerator.new()

const monsterPath = preload("res://Scenes/monster.tscn")
@onready var player = get_parent().get_node("Player")
@onready var navAgent = $NavigationAgent3D

var stayQuiet = false
var SPEED = 4.06

var canInteract = true


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
	if canInteract:
		if player.catFoodPicked:
			spawnMonster()
		
		else:
			var num = rng.randi_range(0, 3)
		
			if num == 0:
				$Meow.pitch_scale = rng.randf_range(0.9, 1.6)
				$Meow.play()
			
			if num == 1:
				$Purr.pitch_scale = rng.randf_range(0.9, 1.6)
				$Purr.play()
			
			if num == 2:
				$Meow2.pitch_scale = rng.randf_range(0.9, 1.6)
				$Meow2.play()
			
			if num == 3:
				$Meow3.pitch_scale = rng.randf_range(0.9, 1.6)
				$Meow3.play()
			
			$Timer.start()
			canInteract = false


func idle():
	$AnimationPlayer.play("idle")
	stayQuiet = true


func chase():
	stayQuiet = false


func update_target_location(target_location):
	navAgent.target_position = target_location


func _on_navigation_agent_3d_target_reached():
	idle()


func _on_timer_timeout():
	canInteract = true
