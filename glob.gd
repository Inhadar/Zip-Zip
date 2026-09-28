extends Node


var last_shape_permision = null
var player_color = Color(1,1,1)




var score_is_banned = false

var enemy_count: int = 0

var all_tiles: int = 0
var game_mode: int = 0


var game_over =false


var full_health = 3
var healt = 3 #damage count


#sound varuable
#var master_sound = 0
#var music = 0
#var sound_effect = 0

var sound_vars = {"Master":5.0,"Music":6.0,"Effects":6.0}




var data_save_file = "user://datasave"



#SAve olunacaq datalar
var score = 0
var upgrade_list = [0,0,0,0]
var player_settings = {"Health":1,"Speed":0,"Score":1,"Jump":0.05}#[1,0,15,0.05]
var player_set = ["normal_circle","normal_rectangle","normal_triangle"]
var sold_skins = ["normal_circle","normal_rectangle","normal_triangle"]

	
func save_data():
	var data_save = File.new()
	data_save.open(data_save_file,File.WRITE)
	data_save.store_var(score)
	data_save.store_var(upgrade_list)
	data_save.store_var(player_settings)
	data_save.store_var(player_set)
	data_save.store_var(sold_skins)
	data_save.store_var(sound_vars)
	data_save.close()


func load_data():
	var load_save = File.new()
	if not load_save.file_exists(data_save_file):
		return false
	load_save.open(data_save_file,File.READ)
	score = load_save.get_var()
	upgrade_list = load_save.get_var()
	player_settings = load_save.get_var()
	player_set = load_save.get_var()
	sold_skins = load_save.get_var()
	sound_vars = load_save.get_var()
	load_save.close()
	return true
