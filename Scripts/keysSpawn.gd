extends Node3D


var rng = RandomNumberGenerator.new()

var lastNum
var key1
var key2


func _ready():
	setFirstKey()
	setSecondKey()
	hideKeys()
	
	eraseOthersKeys()


func setFirstKey():
	var num = rng.randi_range(1, 12)
	
	if num == 1:
		key1 = $key
	
	if num == 2:
		key1 = $key2
	
	if num == 3:
		key1 = $key3
	
	if num == 4:
		key1 = $key4
	
	if num == 5:
		key1 = $key5
	
	if num == 6:
		key1 = $key6
	
	if num == 7:
		key1 = $key7
	
	if num == 8:
		key1 = $key8
	
	if num == 9:
		key1 = $key9
	
	if num == 10:
		key1 = $key10
	
	if num == 11:
		key1 = $key11
	
	if num == 12:
		key1 = $key12
	
	lastNum = num


func setSecondKey():
	var num = rng.randi_range(1, 12)
	if num == lastNum:
		while num == lastNum:
			num = rng.randi_range(1, 12)
	
	if num == 1:
		key2 = $key
	
	if num == 2:
		key2 = $key2
	
	if num == 3:
		key2 = $key3
	
	if num == 4:
		key2 = $key4
	
	if num == 5:
		key2 = $key5
	
	if num == 6:
		key2 = $key6
	
	if num == 7:
		key2 = $key7
	
	if num == 8:
		key2 = $key8
	
	if num == 9:
		key2 = $key9
	
	if num == 10:
		key2 = $key10
	
	if num == 11:
		key2 = $key11
	
	if num == 12:
		key2 = $key12


func eraseOthersKeys():
	var keyList = [$key, $key2, $key3, $key4, $key5, $key6, $key7, $key8, $key9, $key10, $key11, $key12]
	
	for key in keyList:
		if key != key1 and key != key2:
			key.queue_free()


func hideKeys():
	key1.hide()
	key2.hide()


func showKeys():
	key1.show()
	key2.show()
