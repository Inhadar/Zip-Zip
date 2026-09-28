extends Node


export(PackedScene) var Boss_1: PackedScene
export(PackedScene) var star: PackedScene
onready var Player = $Player

#onready var admob= $AdMob


var boss_on_screen = false


var boss_direction = -1#bu WSB'ye asan data yollamaq ucudur

func _ready():
	$Player.shape_permission = 3
	
	if name == "Main":
		MobileAds.load_banner()
		MobileAds.show_banner()
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),global.master_sound)
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),global.music)
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound_Effects"),global.sound_effect)
		

	
	
	
	
	
	if name == "Boss_1":
		$Sounds/Phase_1.play()
		$Start_timer.start()
	#$AnimationPlayer.play("New Anim")
	
	
	get_tree().paused = false
	global.score_is_banned = false
	global.all_tiles = 0
	global.enemy_count = 0
	global.game_over = false
	
func _process(_delta):
	if Input.is_action_just_pressed("jump"):
		shock_wave()
	#$UI/Label.text = "FPS: " + str(Engine.get_frames_per_second())
	#$UI/Score.text = "Score: " + str(global.score)
	#$UI/All_Tiles.text = "All_Tiles: " + str(global.all_tiles)
	#$UI/Game_mode.text = "Game_Mode: " + str(global.game_mode)
	#$UI/Enemy_count.text = "Enemy_count: " + str(global.enemy_count)
	#$UI/Tile_count.text = "Tile_count: " + str($Spawn_Tiles.spawn_count)
	
	
	#for i in $UI/Heart_cont.get_children():
	#	if int(i.name) > global.healt:
	#		i.modulate = $UI.damaged_heart_color
	pass

	

func star_rain():
	for a in range(5):
		yield(get_tree().create_timer(0.7),"timeout")
		$star_rain/AnimationPlayer.play("new_star")
		$star_rain.global_position.x = 0 + a*512
		$Sounds/Star_rain.play()


func spawn_star():
	var new_star = star.instance()
	new_star.x_speed = 0
	new_star.y_speed = 30
	get_tree().current_scene.add_child(new_star)
	#new_star.rotation_degrees = 90
	new_star.global_position = $star_rain/ColorRect/Position2D.global_position


func _on_AnimationPlayer_animation_finished(_anim_name):
	spawn_star()



func screen_shake():
	randomize()
	var rand = Vector2()
	rand.x = rand_range(-3.0, 3.0)
	rand.y = rand_range(-3.0, 3.0)
	$Screen_shake.interpolate_property($Player/Camera,"offset",$Player/Camera.offset,rand,0.1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	$Screen_shake.start()


func _on_Screen_shake_tween_all_completed():
	var rand = Vector2(150,0)
	$Screen_shake.interpolate_property($Player/Camera,"offset",$Player/Camera.offset,rand,0.1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	$Screen_shake.start()



func new_tween(obj,pos,time):
	var new_twn = Tween.new()
	add_child(new_twn)
	new_twn.interpolate_property(obj,"global_position",pos,Vector2(pos.x,pos.y-2000),time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	new_twn.start()
	if obj.global_position.y <= 365:
		new_twn.stop_all()
		new_twn.interpolate_property(obj,"global_position",pos,Vector2(pos.x,2365),time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		new_twn.start()



func rage_of_fish():
	for i in $slag_list.get_children():
		
		$Sounds/Earthquake.play()
		new_tween(i,i.global_position,2)
		yield(get_tree().create_timer(2),"timeout")





func flash():
	$AnimationPlayer.play("flash")



func shock_wave():
	$UI/Shockwave.material.set_shader_param("global_position",Vector2(540,1080))
	$UI/Shockwave/AnimationPlayer.play("New Anim")


func _on_Start_timer_timeout():
	pass
	#$AnimationPlayer.play("New Anim")


func Tween_sprite_deleter(a,b,c,d): #<---Bu funksiya Starshootdan gelir
	a.queue_free()
	b.queue_free()
	c.queue_free()
	d.queue_free()
####Bu funksiya trailden geriye qalan spritelari ve tweenleri silmek ucundur
