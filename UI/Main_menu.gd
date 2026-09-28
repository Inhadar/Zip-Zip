extends Node




func _ready():
	
	global.load_data()
	#global.score = 1000
	$Sprite2/Score.text = str(global.score)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),(global.sound_vars["Master"]-6)*16)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),(global.sound_vars["Music"]-6)*16)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"),(global.sound_vars["Effects"]-6)*16)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Qecal_pressed():
	var _go_to_boss = get_tree().change_scene("res://Levels/Boss_1/Boss_1.tscn")


func _on_Start_pressed():
	var _go_to_main_area = get_tree().change_scene("res://Levels/Main.tscn")


func _on_Shop_pressed():
	var _go_to_shop = get_tree().change_scene("res://Shop/Shop.tscn")


func _on_Settings_pressed():
	var _go_to_settings =  get_tree().change_scene("res://Settings/Settings.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_score_b_pressed():
	#global.score = 1000000
	$Sprite2/Score.text = str(global.score)


func _on_reset_s_pressed():
	#global.score = 0
	$Sprite2/Score.text = str(global.score)


func _on_reset_up_pressed():
	global.upgrade_list = [0,0,0,0]
	global.player_settings = {"Health":1,"Speed":0,"Score":1,"Jump":0.05}#[1,0,15,0.05]

func _on_reset_skins_pressed():
	global.player_set = ["normal_circle","normal_rectangle","normal_triangle"]
	global.sold_skins = ["normal_circle","normal_rectangle","normal_triangle"]
