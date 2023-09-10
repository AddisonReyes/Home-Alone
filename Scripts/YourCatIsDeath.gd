extends Node3D


var rng = RandomNumberGenerator.new()

@onready var interface = get_parent().get_parent().get_node("CanvasLayer").get_node("Interface")
@onready var player = get_parent().get_parent().get_node("Player")
@onready var realCat = get_parent().get_parent().get_node("RealCat")
@onready var phone = get_parent().get_parent().get_node("Phone")
@onready var level = get_parent().get_parent()
@onready var sound1 = $shuiiin

var sound1Bool = false
var thePlayerSeesThePaws = false
var firstObjetivePrinted = false


func _ready():
	$MeowTimer.start()


func _on_area_3d_body_entered(body):
	if body is Player and firstObjetivePrinted == false:
		realCat.interact()
		firstObjetivePrinted = true
		interface.printObjetive()
		
	if player.myCatIsDeath and sound1Bool == false:
		$SecondObjetiveTimer.start()
		sound1Bool = true
		sound1.play()
	
	if $CatGhostPaws.visible and body is Player and thePlayerSeesThePaws == false:
		phone.canStop = true
		thePlayerSeesThePaws = true
		$MonsterSpawnTimer.start()


func _on_meow_timer_timeout():
	if firstObjetivePrinted == false:
		realCat.interact()
		
		var time = rng.randi_range(6, 16)
		$MeowTimer.wait_time = time
		$MeowTimer.start()
