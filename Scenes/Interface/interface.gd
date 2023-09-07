extends Control


@onready var player = get_parent().get_node("Player")

@onready var volume = $VBoxContainer2/Volume
@onready var dot = $VBoxContainer/Dot


func _process(delta):
	if player == null:
		return
	
	if player.printDot:
		dot.visible = true
	
	else:
		dot.visible = false
	
	if player.doingNoise:
		volume.visible = true
	
	else:
		volume.visible = false
