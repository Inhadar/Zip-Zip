extends Node

#var sound_value = 12



func _ready():
	global.load_data()

	for i in $ScrollContainer/CenterContainer/VBox.get_children():
		
		var plus_button = i.get_node("plus")
		var minus_button = i.get_node("minus")
		plus_button.connect("pressed",self,"plus_pressed",[i])
		minus_button.connect("pressed",self,"minus_pressed",[i])
		
		#if i.name == "Master":
			#i.value = global.master_sound
		#elif i.name == "Music":
			#i.value = global.music
		#elif i.name == "Effects":
		#	i.value = global.sound_effect
		var bars = i.get_node("Bar").get_children()
		var value = global.sound_vars[i.name]
		for bar in range(int(value)):
			bars[bar].frame = 0
			var sound_value = (value-bars.size()) * 16
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index(i.name),sound_value)
	


func plus_pressed(i):
	var bars = i.get_node("Bar").get_children()
	var value = global.sound_vars[i.name]
	if value < bars.size():
		value +=1.0
		global.sound_vars[i.name] = value
		var sound_value = (value-bars.size())* 16
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(i.name),sound_value)
		print(sound_value)
	for bar in range(value):
		bars[bar].frame = 0
	
	

func minus_pressed(i):
	var bars = i.get_node("Bar").get_children()
	var value = global.sound_vars[i.name]
	if value > 0.0:
		value -=1.0
		global.sound_vars[i.name] = value
		bars[value].frame = 1
		var sound_value = (value-bars.size())* 16
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(i.name),sound_value)

func _on_back_pressed():
	global.save_data()
	get_tree().change_scene("res://UI/Main_menu.tscn")
