extends KinematicBody2D


var spike_sprite_1 = preload("res://zip_zip/New_Style/Game_area/yellov_plant.png")
var spike_sprite_2 = preload("res://zip_zip/New_Style/Game_area/spike.png")

var velocity = Vector2()
var move_speed = 100
onready var Player = get_tree().current_scene.get_node("Player")
onready var spawner
onready var enemy_spawner
onready var background
onready var UI

var one_permision =true

var color_1 = Color(0.937255, 0.278431, 0.435294)
var color_2 = Color(0.023529, 0.839216, 0.627451)
var color_3 = Color(1, 0.819608, 0.4)
var color_4 = Color(1, 1, 1)
var color_set = {0:color_1,1:color_2,2:color_3,3:color_4}
var current_color = 0

var current_shape = 0
export var current_tile = 0
var spike_is_active = false



#World maps
var map1
var map2
var map3
var map_set = [map1,map2,map3]


var boss_on_screen = false

export var normal_tile = false


var bonus_score = 0

var delete_perm = true
func _ready():
	
	bonus_score = global.player_settings["Score"]
	$Sprite.frame = current_tile
	
	
	
	
	
	if normal_tile == false:
		spawner = get_tree().current_scene.get_node("Spawn_Tiles")
		enemy_spawner = get_tree().current_scene.get_node("Enemy_Spawner")
		#background = Player.get_node("ParallaxBackground/ColorRect") 
		UI = get_tree().current_scene.get_node("UI")
	#$Area2D/AnimationPlayer3.play("New Anim")

	if normal_tile == false:
			
	#openning
		if global.score <8:
			spawner.dtt = 600
			spawner.shr = 0
			
			
			Player.shape_permission = 1
			current_tile =  0
			current_shape = 0
			current_color = 3
			$Sprite.frame =current_tile
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]

	#map - 1
		#level: 1-1
		elif global.score >=8 and global.score <16:
			spawner.dtt = 600
			spawner.shr = 0
			#show new mechanics set current map
			Player.shape_permission = 1
			current_tile =  1
			current_shape = 0#random_shape
			current_color = 3
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Sprite.frame = current_tile
			$Area2D/Sprite.modulate = color_set[current_color]
			spawner.circle_spawn_perm = false
		#level: 1-2
		elif global.score >= 16 and global.score < 32:
			spawner.dtt = 650
			spawner.shr = 5
			#if firs game stop and show new mechanics: check game if firs or not from global list with level name [level-1: true]
			Player.shape_permission = 2
			current_tile =  0
			randomize()
			spawner.circle_spawn_perm = false
			var random_shape = randi()%2
			current_shape = random_shape
			current_color = 3
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Sprite.frame = current_tile
			$Area2D/Sprite.modulate = color_set[current_color]
			
			###########set  spawnable tile with rate#########
			#randomize()
			#var tile_rate = randi()%100
			#if tile_rate in range(30):
			#	current_tile =  1
			#	$Sprite.frame =current_tile
			#else:
			#	current_tile =  0
			#	$Sprite.frame =current_tile

		#level: 1-3
		elif global.score >= 32 and global.score < 64:
			spawner.dtt = 650
			spawner.shr = 5
			#if firs game stop and show new mechanics: check game if firs or not from global list with level name [level-1: true]
			Player.shape_permission = 2
			randomize()
			var tile_rate = randi()%100
			if tile_rate in range(30):
				current_tile =  0
				$Sprite.frame =current_tile
			elif tile_rate in range(30,100):
				current_tile =  2
				$Sprite.frame =current_tile
			#else:
			#	current_tile =  0
			#	$Sprite.frame =current_tile
			spawner.circle_spawn_perm = false
			var random_shape = randi()%2
			current_shape = random_shape
			current_color = 3
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]

		#level: 1-4
		elif global.score >= 64 and global.score < 128:
			spawner.dtt = 700
			spawner.shr = 10
			#if firs game stop and show new mechanics: check game if firs or not from global list with level name [level-1: true]
			Player.shape_permission = 2
			spawner.circle_spawn_perm = false
			var random_shape = randi()%2
			current_shape = random_shape
			current_tile =  2
			current_color = 3
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]
			$Sprite.frame =current_tile




	#map - 2
		#level: 2-1
		elif global.score >= 128 and global.score < 256:
			spawner.dtt = 700
			spawner.shr = 10
			#show new mechanics set current map
			randomize()
			Player.shape_permission = 3
			spawner.circle_spawn_perm = false
			var random_shape = randi()%3
			current_shape = random_shape
			current_tile =  0
			current_color = 3
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]
			$Sprite.frame =current_tile
			
			enemy_spawner.spawn_permision = true
			enemy_spawner.enemy_type = "LE"
			enemy_spawner.fly_enemy_mode = "line"

		#level: 2-2
		elif global.score >= 256 and global.score < 512:
			spawner.dtt = 800
			spawner.shr = 15
			randomize()
			
			var tile_rate = randi()%100
			if tile_rate in range(30):
				current_tile =  0
			elif tile_rate in range(30,100):
				current_tile =  2
				
			spawner.circle_spawn_perm = false
			var random_shape = randi()%3
			current_shape = random_shape
			
			Player.shape_permission = 3
			current_color = 3
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]
			$Sprite.frame =current_tile
			
			enemy_spawner.spawn_permision = true
			enemy_spawner.enemy_type = "LE"
			enemy_spawner.fly_enemy_mode = "line"
			
		#level: 2-3
		elif global.score >= 512 and global.score < 1024:
			spawner.dtt = 800
			spawner.shr = 15
			#show new enemy moves
			randomize()
			
			var tile_rate = randi()%100
			if tile_rate in range(30):
				current_tile =  0
			elif tile_rate in range(30,100):
				current_tile =  2
				
			spawner.circle_spawn_perm = false
			var random_shape = randi()%2
			current_shape = random_shape
			
			Player.shape_permission = 3
			current_color = 3
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]
			$Sprite.frame =current_tile
			
			enemy_spawner.spawn_permision = true
			enemy_spawner.enemy_type = "WE"
			enemy_spawner.fly_enemy_mode = "wave"
		
		#level: 2-4
		elif global.score >= 1024 and global.score < 2048:
			spawner.dtt = 900
			spawner.shr =20
			#show new mechanics
			randomize()
			Player.shape_permission = 3
			var random_shape = randi()%3
			current_shape = random_shape
			current_tile =  0
			
			spawner.circle_spawn_perm = true
			spawner.ccr = 2
			var random_color = randi() % (2)
			current_color = random_color
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]
			$Sprite.frame =current_tile
			
			enemy_spawner.spawn_permision = false
			#enemy_spawner.enemy_type = "FE"
			#enemy_spawner.fly_enemy_mode = "line"

		#level: 2-5
		elif global.score >= 2048 and global.score < 4096:
			spawner.dtt = 900
			spawner.shr = 20
			#show new mechanics
			randomize()
			Player.shape_permission = 3
			var random_shape = randi()%4
			current_shape = random_shape
			
			var tile_rate = randi()%100
			if tile_rate in range(15):
				current_tile =  0
			elif tile_rate in range(15,45):
				current_tile =  1
			elif tile_rate in range(45,100):
				current_tile =  2
				
				
				
			spawner.circle_spawn_perm = true
			spawner.ccr = 3
			if random_shape != 3:
				var random_color = randi() % 3
				current_color = random_color
			else:
				current_color = 3
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]
			$Sprite.frame =current_tile
			
			enemy_spawner.spawn_permision = false
			#enemy_spawner.enemy_type = "FE"
			#enemy_spawner.fly_enemy_mode = "line"

	#map - 3
		#level: 3-1
		elif global.score >= 4096 and global.score < 8192:
			spawner.dtt = 900
			spawner.shr = 25
			#show new mechanics set current map
			randomize()
			Player.shape_permission = 3
			var random_shape = randi()%5
			current_shape = random_shape
			
			var tile_rate = randi()%100
			if tile_rate in range(15):
				current_tile =  0
			elif tile_rate in range(15,45):
				current_tile =  1
			elif tile_rate in range(45,100):
				current_tile =  2
				
			spawner.circle_spawn_perm = true
			spawner.ccr = 3
			if random_shape < 3:
				var random_color = randi() % (color_set.size()-1)
				current_color = random_color
			else:
				current_color= 3
				
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]
			$Sprite.frame =current_tile
			
			enemy_spawner.spawn_permision = true
			#enemy_spawner.enemy_type = "FE"
			#enemy_spawner.fly_enemy_mode = "line"
		#level: 3-2
		elif global.score >= 8192 and global.score < 16384:
			spawner.dtt = 900
			spawner.shr = 25
			#show new mechanics set current map
			randomize()
			Player.shape_permission = 3
			var random_shape = randi()%6
			current_shape = random_shape
			
			var tile_rate = randi()%100
			if tile_rate in range(15):
				current_tile =  0
			elif tile_rate in range(15,45):
				current_tile =  1
			elif tile_rate in range(45,100):
				current_tile =  2
				
			spawner.circle_spawn_perm = true
			spawner.ccr = 3
			
			if random_shape < 3:
				var random_color = randi() % (color_set.size()-1)
				current_color = random_color
			else:
				current_color= 3
				
				
			$Area2D/Sprite.frame = current_shape
			$Area2D/Sprite/Sprite2.frame = current_shape
			$Area2D/Sprite.modulate = color_set[current_color]
			$Sprite.frame =current_tile
			
			enemy_spawner.spawn_permision = true
			#enemy_spawner.enemy_type = "FE"
			#enemy_spawner.fly_enemy_mode = "line"
		#level: 3-3
		elif global.score >= 16384 and global.score < 32768:
			spawner.dtt = 900
			spawner.shr = 30
			#show new mechanics set current map
			randomize()
			Player.shape_permission = 3
			var random_shape = randi()%7
			if random_shape < 6:
				current_shape = random_shape
				var tile_rate = randi()%100
				if tile_rate in range(15):
					current_tile =  0
				elif tile_rate in range(15,30):
					current_tile =  1
				elif tile_rate in range(30,45):
					current_tile =  2
				elif tile_rate in range(45,100):
					current_tile = 3
				spawner.circle_spawn_perm = true
				spawner.ccr = 3
				
				if random_shape < 3:
					var random_color = randi() % (color_set.size()-1)
					current_color = random_color
				else:
					current_color= 3
				$Area2D/Sprite.frame = current_shape
				$Area2D/Sprite/Sprite2.frame = current_shape
				$Area2D/Sprite.modulate = color_set[current_color]
				$Sprite.frame =current_tile
			else:
				current_shape = 6
				$Area2D/AnimationPlayer.play("New Anim")
				$Area2D/AnimationPlayer2.play("New Anim")
		
		

	#Map - Boss
		#Boss-1
		elif global.score >= 32768:# and global.score < 81920:
			$Area2D/CollisionShape2D.set_deferred("disabled",true)
			$Area2D.hide()
			spawner.dtt = 448
			spawner.shr = 0
			#SPAWN BOSS GATE!!!!!!!!!!
			
		#var random_shape = randi()%7
		#if random_shape < 6:
		#	$Area2D/Sprite.frame = random_shape
		#	$Area2D/Sprite/Sprite2.frame = random_shape
		#	current_shape = random_shape
			
		#else:
		#	current_shape = 6
		#	$Area2D/AnimationPlayer.play("New Anim")
		#	$Area2D/AnimationPlayer2.play("New Anim")
		
		

		#if random_shape < 3:
		#	var random_color = randi() % (color_set.size()-1)
		#	current_color = random_color
		#	$Area2D/Sprite.modulate = color_set[current_color]
		#else:
		#	$Area2D/Sprite.modulate = color_set[3]
	
	else:
		$Area2D.hide()
		
		
	
	
func _physics_process(_delta):
	#print(global_position.distance_to(Player.global_position))
	
	if normal_tile == false:
		if global_position.distance_to(Player.global_position) > 2500 and global_position.x < Player.global_position.x:
			if delete_perm:
				queue_free()
				spawner.tile_spawn_count +=1
				print("silindim")
			if global_position.distance_to(spawner.global_position) > 600 and global_position.x < spawner.global_position.x and one_permision:
				one_permision = false
	velocity = move_and_slide(velocity,Vector2.UP)
		
	#move(delta)
	#move_and_slide(velocity,Vector2.UP)
	



func move(_delta):
	velocity.x = -move_speed

func tile_timer(wait_time):
	var new_timer = Timer.new()
	add_child(new_timer)
	new_timer.connect("timeout",self,"Tile_timeout")
	new_timer.one_shot = true
	new_timer.wait_time = wait_time
	new_timer.start()
func Tile_timeout():
	if current_tile == 1:
		$Sprite.hide()
		$CollisionShape2D.set_deferred("disabled",true)
		if normal_tile == true:
			$Area2D/CollisionShape2D.set_deferred("disabled",true)
		$Restore_timer.start()
	if current_tile == 2:
		$Spike.show()
		$AnimationPlayer.play("Spike_anim")
		$Sound_container/Spike_ready.play()
	if current_tile == 3:
		$Spike.show()
		$AnimationPlayer.play("Spike_anim")
		velocity.y -= 600
		$Sound_container/Spike_ready.play()
		$Sound_container/Mover_Tile.play()
		
		
		
func fx_timer(wait_time,player):
	var new_timer = Timer.new()
	add_child(new_timer)
	new_timer.connect("timeout",self,"Fx_timeout",[player])
	new_timer.one_shot = true
	new_timer.wait_time = wait_time
	new_timer.start()

func Fx_timeout(player):
	if current_shape == 3:
		#player.get_node("Camera").zoom  = Vector2(1.3,1.3)
		player.get_node("Camera").offset.y = -500
		player.get_node("Camera").rotation_degrees = 0
		
		$Sound_container/Reverse.play()
		yield(get_tree().create_timer(0.7),"timeout")
		delete_perm = true
	elif current_shape == 4:
		var platforms = get_tree().get_nodes_in_group("Platform")
		for plt in platforms:
			var area_var = plt.get_node_or_null("Area2D")
			if area_var != null:
				plt.get_node("Area2D/Ban").hide()
		global.score_is_banned = false
		$Sound_container/Block.play()
		yield(get_tree().create_timer(0.7),"timeout")
		delete_perm = true
	elif current_shape == 5:
		get_parent().get_node("UI/Ink").hide()
		delete_perm = true
	else:
		var area_var = get_node_or_null("Area2D")
		if area_var != null:
			$Area2D.queue_free()
	
	


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		
		if current_tile == 1:
			#Break Animation here
			tile_timer(1)
		if current_tile == 2:
			if spike_is_active == false:
				$Spike.show()
				$Spike/SS.texture = spike_sprite_1
				tile_timer(0.3)
				spike_is_active  =true
		if current_tile == 3:
			if spike_is_active == false:
				$Spike.show()
				$Spike/SS.texture = spike_sprite_1
				tile_timer(0.3)
				spike_is_active  =true
				
		if normal_tile == false:
			if global.score_is_banned == false:
				if current_shape <3:
					if body.current_sprite == $Area2D/Sprite.frame and body.current_color == current_color:
						$Area2D/AnimationPlayer.play("New Anim (2)")
						global.score+=5*bonus_score
						$Area2D/Sprite/Label.text = str(5*bonus_score)
						$Sound_container/Nice.play()
					elif body.current_sprite != $Area2D/Sprite.frame and body.current_color == current_color:
						$Area2D/AnimationPlayer.play("New Anim (2)")
						global.score+=1*bonus_score
						$Area2D/Sprite/Label.text = str(1*bonus_score)
						$Sound_container/Not_Bad.play()
					elif body.current_sprite == $Area2D/Sprite.frame and body.current_color != current_color:
						$Area2D/AnimationPlayer.play("New Anim (2)")
						global.score+=1*bonus_score
						$Area2D/Sprite/Label.text = str(1*bonus_score)
						$Sound_container/Not_Bad.play()
					elif body.current_sprite != $Area2D/Sprite.frame and body.current_color != current_color:
						$Area2D/AnimationPlayer.play("New Anim (2)")
						global.score -=5*bonus_score
						$Area2D/Sprite/Label.text = str(-5*bonus_score)
						$Sound_container/Bad.play()
					fx_timer(0.7,body)
				elif current_shape == 3:
					#body.get_node("Camera").zoom  = Vector2(1.3,-1.3)
					
					body.get_node("Camera").offset.y = 2400
					body.get_node("Camera").rotation_degrees = 180
		
					
					fx_timer(5,body)
					$Area2D.queue_free()
					$Sound_container/Reverse.play()
					delete_perm = false
				elif current_shape == 4:
					var platforms = get_tree().get_nodes_in_group("Platform")
					for plt in platforms:
						var area_var = plt.get_node_or_null("Area2D")
						if area_var != null:
							plt.get_node("Area2D/Ban").show()
							$Sound_container/Block.play()
							delete_perm = false
					global.score_is_banned = true
					fx_timer(5,body)
					$Area2D.queue_free()
				
				elif current_shape == 5:
					get_parent().get_node("UI/Ink").show()
					fx_timer(3,body)
					$Area2D.queue_free()
					delete_perm = false
					$Sound_container/Ink.play()
				elif current_shape == 6:
					$Area2D/AnimationPlayer.play("New Anim (2)")
					#background.texture = b_texture_set[current_color]
					global.score+=10*bonus_score
					$Area2D/Sprite/Label.text = str(10*bonus_score)
					fx_timer(0.7,body)
					$Sound_container/Excellent.play()


func _on_Spike_body_entered(body):
	if body.name == "Player":
		if current_tile == 1:
			pass
		elif current_tile ==2:
			#$Spike/Spike_blood.show()
			$Spike/Spike_blood.modulate = body.color_set[body.current_color]
			body.damage("spike")
			$Sound_container/Spike_damage.play()
			#yield(get_tree().create_timer(0.5),"timeout")
			#get_tree().reload_current_scene()
		elif current_tile ==3:
			#$Spike/Spike_blood.show()
			$Spike/Spike_blood.modulate = body.color_set[body.current_color]
			body.damage("spike")
			#yield(get_tree().create_timer(0.5),"timeout")
			#get_tree().reload_current_scene()


func _on_Restore_timer_timeout():
	if normal_tile:
		$Sprite.show()
		$Area2D/CollisionShape2D.set_deferred("disabled",false)
		$CollisionShape2D.set_deferred("disabled",false)

