extends Node3D


@onready var player = get_parent().get_parent().get_node("Player")
@onready var level = get_parent().get_parent()
@onready var sound1 = $shuiiin

var sound1Bool = false
var thePlayerSeesThePaws = false


func _on_area_3d_body_entered(body):
	if player.myCatIsDeath and sound1Bool == false:
		sound1Bool = true
		sound1.play()
	
	if $CatGhostPaws.visible and body is Player and thePlayerSeesThePaws == false:
		thePlayerSeesThePaws = true
		level.monsterSpawn()
