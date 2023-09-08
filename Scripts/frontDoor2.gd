extends Node3D


@onready var door = $Pivot/PhysicDoor


var playerSurvived = false


func _physics_process(delta):
	playerSurvived = door.playerSurvived
