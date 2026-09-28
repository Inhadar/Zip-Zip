extends CanvasLayer


signal left
signal right
signal idle
signal click



var heart_color = Color(1, 0.219608, 0.219608)
var damaged_heart_color = Color(0.261719, 0.063385, 0.063385)

var touch = false
var Touch_pos = Vector2()
var delta_X
var new_delta_x
var swiping = false
var click_sensitivity= 30 

func _ready():
	global.player_color = get_tree().current_scene.get_node("Player").color_set[get_tree().current_scene.get_node("Player").current_color]
	global.full_health = global.player_settings["Health"]#save bura gelecek
	global.healt = global.full_health
	#global.score =40000#10000000#burada save_gelecek
	$Data_Bar/Score_Label.text = str(global.score)
	$Data_Bar/ColorData.modulate = global.player_color
	#for skin in range(get_tree().current_scene.get_node("Player").shape_permission):
	#	$Data_Bar/Current_Sprites.get_children()[skin].show()

	set_data_bar()
		
	
	#for i in $Heart_cont.get_children():
	#	i.modulate = heart_color
	$Data_Bar/Health_container.get_children()[0].texture =load("res://zip_zip/UI/Healt_score_bar/healt_bar/full_begin.png")
	if global.healt -1 != 0:
		$Data_Bar/Health_container.get_children()[global.healt-1].texture =load("res://zip_zip/UI/Healt_score_bar/healt_bar/full_end.png")
	for i in $Data_Bar/Health_container.get_children():
		if int(i.name) <= global.healt-1:
			i.show()
		else:
			i.hide()
		
		
	for skin_index in range(3):
		if global.player_set[skin_index]!= null:
			$Data_Bar/Current_Sprites.get_children()[skin_index].texture = load("res://zip_zip/Players/Player_sprites/"+global.player_set[skin_index]+".png")
	
	
	for skin in range(get_tree().current_scene.get_node("Player").shape_permission):
		$Data_Bar/Current_Sprites.get_children()[skin].show()
		
func set_data_bar():
	if abs(global.score)>=0 and abs(global.score)<10:
		$Data_Bar/ScoreBoard.position.x = 18
	elif abs(global.score)>=10 and abs(global.score)<100:
		$Data_Bar/ScoreBoard.position.x = 80
	elif abs(global.score)>=100 and abs(global.score)<1000:
		$Data_Bar/ScoreBoard.position.x = 155
	elif abs(global.score)>=1000 and abs(global.score)<10000:
		$Data_Bar/ScoreBoard.position.x = 225
	elif abs(global.score)>=10000 and abs(global.score)<100000:
		$Data_Bar/ScoreBoard.position.x = 295
	elif abs(global.score)>=100000 and abs(global.score)<1000000:
		$Data_Bar/ScoreBoard.position.x = 365
	elif abs(global.score)>=1000000 and abs(global.score)<10000000:
		$Data_Bar/ScoreBoard.position.x = 435
	elif abs(global.score)>=10000000 and abs(global.score)<100000000:
		$Data_Bar/ScoreBoard.position.x = 470
	
func _input(event):
	$Control/data1.text  = "Health: "+ str(global.player_settings["Health"])
	$Control/data2.text  = "Score: "+str(global.player_settings["Score"])
	$Control/data3.text  = "Speed: "+str(get_tree().current_scene.get_node("Player").speed)
	$Control/data4.text  = "jump: "+str(global.player_settings["Jump"])
	
	
	
	$Data_Bar/Score_Label.text = str(global.score)
	$Data_Bar/ColorData.modulate = global.player_color

	set_data_bar()
		
	for skin in range(get_tree().current_scene.get_node("Player").shape_permission):
		$Data_Bar/Current_Sprites.get_children()[skin].show()
		
		
	
	if touch:
		var a = get_viewport().get_visible_rect().size.x
		#$Bar/Sprite.position.x = a/2
		#print(get_viewport().get_visible_rect().size)
		#print($Bar/ray.get_rect().size.x * $Bar/ray.scale.x)
		if event is InputEventScreenTouch and event.is_pressed():
			Touch_pos = event.get_position()
			delta_X = Touch_pos.x - $Bar/Sprite.position.x
		

		elif event is InputEventScreenDrag:
			Touch_pos = event.get_position()
			new_delta_x =  Touch_pos.x - delta_X
			if abs(new_delta_x) < abs(a/4):
				$Bar/Sprite.set_position(Vector2(new_delta_x,$Bar/Sprite.position.y))
				#print(round(new_delta_x))
			if abs(new_delta_x) > click_sensitivity:
				swiping =true
				if new_delta_x >0:
					emit_signal("right")
					#print("right")
				else:
					emit_signal("left")
					#print("left")
			else:
				#print("idle") 
				emit_signal("idle")
	else:
		$Bar/Sprite.set_position(Vector2(0,0))
		swiping =false
		emit_signal("idle")
		#print("idle")
		new_delta_x = 0









func check_health():
	for i in range(global.full_health):
		if int($Data_Bar/Health_container.get_children()[i].name) >global.healt-1:
			if i == 0:
				$Data_Bar/Health_container.get_children()[i].texture = load("res://zip_zip/UI/Healt_score_bar/healt_bar/empty_begin.png") 
			elif i >0 and i<global.full_health-1:
				$Data_Bar/Health_container.get_children()[i].texture =load("res://zip_zip/UI/Healt_score_bar/healt_bar/empty_middle.png")
			elif i == global.full_health-1:
				$Data_Bar/Health_container.get_children()[i].texture = load("res://zip_zip/UI/Healt_score_bar/healt_bar/empty_end.png")


func _on_TouchScreenButton_pressed():
	touch = true
	#print(touch)

func _on_TouchScreenButton_released():
	touch = false
	if swiping == false:
		emit_signal("click")
		print("click")
	#print(touch)


func _on_back_pressed():
	$Bar.hide()
	$TouchScreenButton.hide()
	get_tree().paused = true
	$Pause_menu.show()



func _on_Yes_pressed():
	var _goto_main_menu =get_tree().change_scene("res://UI/Main_menu.tscn")
	global.save_data()


func _on_No_pressed():
	get_tree().paused = false
	$Pause_menu.hide()
	$Bar.show()
	$TouchScreenButton.show()


func the_end():
	$the_end_anim.play("New Anim")


func _on_the_end_anim_animation_finished(_anim_name):
	var _goto_credits = get_tree().change_scene("res://Credits_scenes/Credits.tscn")
