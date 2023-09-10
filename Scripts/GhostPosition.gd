extends Node3D


var rng = RandomNumberGenerator.new()

@onready var markerPosition1 = $Marker3D
@onready var markerPosition2 = $Marker3D2
@onready var markerPosition3 = $Marker3D3
@onready var markerPosition4 = $Marker3D4
@onready var markerPosition5 = $Marker3D5
@onready var markerPosition6 = $Marker3D6
@onready var markerPosition7 = $Marker3D7
@onready var markerPosition8 = $Marker3D8
@onready var markerPosition9 = $Marker3D9
@onready var markerPosition10 = $Marker3D10
@onready var markerPosition11 = $Marker3D11
@onready var markerPosition12 = $Marker3D12
@onready var markerPosition13 = $Marker3D13
@onready var markerPosition14 = $Marker3D14
@onready var markerPosition15 = $Marker3D15
@onready var markerPosition16 = $Marker3D16
@onready var markerPosition17 = $Marker3D17
@onready var markerPosition18 = $Marker3D18


func givePosition():
	var num = rng.randi_range(1, 18)
	
	if num == 1:
		return markerPosition1.position
	
	elif num == 2:
		return markerPosition2.position
	
	elif num == 3:
		return markerPosition3.position
	
	elif num == 4:
		return markerPosition4.position
	
	elif num == 5:
		return markerPosition5.position
	
	elif num == 6:
		return markerPosition6.position
	
	elif num == 7:
		return markerPosition7.position
	
	elif num == 8:
		return markerPosition8.position
	
	elif num == 9:
		return markerPosition9.position
	
	elif num == 10:
		return markerPosition10.position
	
	elif num == 11:
		return markerPosition11.position
	
	elif num == 12:
		return markerPosition12.position
	
	elif num == 13:
		return markerPosition13.position
	
	elif num == 14:
		return markerPosition14.position
	
	elif num == 15:
		return markerPosition15.position
	
	elif num == 16:
		return markerPosition16.position
	
	elif num == 17:
		return markerPosition17.position
	
	else:
		return markerPosition18.position
