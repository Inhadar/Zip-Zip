extends Node

#onready var admob = $AdMob



var health_data ={1:[2,500],2:[3,2500],3:[4,5000],4:[5,10000],5:[6,20000]}
var speed_data = {1:[5,400],2:[10,1200],3:[10,3000],4:[15,7000],5:[20,15000]}
var score_data = {1:[5,2000],2:[10,5000],3:[25,15000],4:[50,25000],5:[100,30000]}
var jump_data= {1:[0.1,400],2:[0.15,1500],3:[0.2,4000],4:[0.25,10000],5:[0.3,18000]}

var shop_data_container = {"Health":health_data,"Speed":speed_data,"Score":score_data,"Jump":jump_data}

var skin_price_list = [0,100,200,300,500,"video","video"] 



func _ready():
	
	MobileAds.load_banner()
	MobileAds.show_banner()
	
	$in_shop_design/scoreboard/ScoreLabel.text = str(global.score) 
	
	for i in range(4):
		var current_market = $Upgrades_shop/CenterContainer/MarginContainer/VBoxContainer.get_children()[i]
		current_market.get_node("Buy").connect("pressed",self,"Upgrades_Buy_pressed",[current_market,i])
		#current_market.get_node("Bar").value = global.upgrade_list[i]
		for bar in range(global.upgrade_list[i]):
			current_market.get_node("Bar").get_children()[bar].frame = 1
			
		
		var current_value = int(global.upgrade_list[i])
		if current_value <5:
			current_market.get_node("Buy/Price").text = str(shop_data_container[current_market.name][current_value+1][1])
			if current_value > 0:
				global.player_settings[current_market.name] = shop_data_container[current_market.name][current_value][0]
			
			
		elif current_value >=5:
			current_market.get_node("Buy/Price").text = "MAX"
			global.player_settings[current_market.name] = shop_data_container[current_market.name][5][0]
		
		
		
		
		
		
		
		
		
		
		
	for i in range($Skins_shop/CenterContainer/MarginContainer/VBoxContainer.get_children().size()):
		var current_board =  $Skins_shop/CenterContainer/MarginContainer/VBoxContainer.get_children()[i]
		for j in range(3):
			var current_button =  current_board.get_node("HBoxContainer").get_children()[j]
			current_button.connect("pressed",self,"Skins_Buy_pressed",[current_button,j,skin_price_list[i]])
			
			if skin_price_list[i] is int:
				current_board.get_node("Price").text = str(skin_price_list[i])
				current_board.get_node("Price").show()
				current_board.get_node("video_icon").hide()
			else:
				current_board.get_node("Price").hide()
				current_board.get_node("video_icon").show()
				
			if current_button.name in global.sold_skins:
				current_board.get_node("Price").text = "Sold"
				if current_button.name in global.player_set:
					#current_board.get_node("Price").text = "Equip"
					current_button.toggle_mode = true
					current_button.pressed = true




func Upgrades_Buy_pressed(current_market,i):
	var Bar_set = current_market.get_node("Bar")
	
	var current_price = int(current_market.get_node("Buy/Price").text)
	if global.score >= current_price:
		if global.upgrade_list[i] < 5:
			global.upgrade_list[i] = global.upgrade_list[i]+1
			for bar in range(global.upgrade_list[i]):
				Bar_set.get_children()[bar].frame = 1
				
		global.score-=current_price
		$in_shop_design/scoreboard/ScoreLabel.text = str(global.score) 
		#global.upgrade_list[i] = scroll_bar.value
		
		
		var current_value = global.upgrade_list[i]
		if current_value <5:
			current_market.get_node("Buy/Price").text = str(shop_data_container[current_market.name][int(current_value+1)][1])
			if current_value > 0:
				global.player_settings[current_market.name] = shop_data_container[current_market.name][int(current_value)][0]
	
		elif current_value >=5:
			current_market.get_node("Buy/Price").text = "MAX"
			global.player_settings[current_market.name] = shop_data_container[current_market.name][5][0]
func Skins_Buy_pressed(i,index,price):
	
	if price is int:
		print(price)
		if  !i.name in global.sold_skins:
			if global.score >= price:
				global.player_set[index] = i.name
				
				var player_set = i.get_node("icon")
				global.score -= price
				global.sold_skins.append(i.name)
				$in_shop_design/scoreboard/ScoreLabel.text = str(global.score)
				
				
				
				var cbset = i.get_parent().get_children()
				
				var cb_count = 0
				for cb in cbset:
					if cb.name in global.sold_skins:
						cb_count +=1
				if cb_count == 3:
					i.get_parent().get_parent().get_node("Price").text = "Sold"
				
				
				var current_group = i.get_groups()[0]
				var current_shop_buttons= get_tree().get_nodes_in_group(current_group)#sehnedeki diger butonlari cagiririq
				
				
				for sb in  current_shop_buttons:
					sb.pressed = false
					sb.toggle_mode = false
				i.toggle_mode = true
				i.pressed = true
				
		else:
			global.player_set[index] = i.name
			print(i.name)
			var player_set = i.get_node("icon")
			$in_shop_design/scoreboard/ScoreLabel.text = str(global.score)
			var current_group = i.get_groups()[0]
			print(current_group)
			
			var current_shop_buttons= get_tree().get_nodes_in_group(current_group)
			

			for sb in  current_shop_buttons:
				sb.pressed = false
				sb.toggle_mode = false
			i.toggle_mode = true
			i.pressed = true

	else:
		if !i.name in global.sold_skins:
			MobileAds.load_rewarded()
			MobileAds.show_rewarded()
			#if !admob.is_connected("rewarded_video_closed",self,"Revarded_closed"):
			#	admob.connect("rewarded_video_closed",self,"Revarded_closed",[i,index])
			#else:
			#	Revarded_closed(i,index)
		else:
			global.player_set[index] = i.name
			print(i.name)
			var player_set = i.get_node("icon")
			$in_shop_design/scoreboard/ScoreLabel.text = str(global.score)
			var current_group = i.get_groups()[0]
			print(current_group)
			
			var current_shop_buttons= get_tree().get_nodes_in_group(current_group)
			

			for sb in  current_shop_buttons:
				sb.pressed = false
				sb.toggle_mode = false
			i.toggle_mode = true
			i.pressed = true
		
func _on_back_pressed():
	if $main_shop_buttons.visible == true:
		get_tree().change_scene("res://UI/Main_menu.tscn")
		global.save_data()
	else:
		$main_shop_buttons.visible = true
		$main_shop_design.show()
		$in_shop_design.hide()
		$Upgrades_shop.hide()
		$Skins_shop.hide()
		

func _on_Upgrades_pressed():
	$main_shop_buttons.visible = false
	$main_shop_design.hide()
	$Upgrades_shop.show()
	$in_shop_design.show()


func _on_Skins_pressed():
	$main_shop_buttons.visible = false
	$main_shop_design.hide()
	$Skins_shop.show()
	$in_shop_design.show()





func _on_AdMob_rewarded_video_loaded():
	MobileAds.load_rewarded()
	MobileAds.show_rewarded()
	$admob_test_label.text =  "reward_loaded"
	
	
func Revarded_closed(i,index):
	$admob_test_label.text = "rewarded_closed: " + i.name
	global.player_set[index] = i.name
	
	var player_set = i.get_node("icon")
	global.sold_skins.append(i.name)
	
	
	var cbset = i.get_parent().get_children()
	
	var cb_count = 0
	for cb in cbset:
		if cb.name in global.sold_skins:
			cb_count +=1
	if cb_count == 3:
		i.get_parent().get_parent().get_node("Price").text = "Sold"
	
	
	var current_group = i.get_groups()[0]
	var current_shop_buttons= get_tree().get_nodes_in_group(current_group)#sehnedeki diger butonlari cagiririq
	
	
	for sb in  current_shop_buttons:
		sb.pressed = false
		sb.toggle_mode = false
	i.toggle_mode = true
	i.pressed = true


func _on_AdMob_rewarded_video_failed_to_load(error_code):
	$admob_test_label.text = "rewarded_failed"


