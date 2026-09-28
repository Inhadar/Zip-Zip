extends RigidBody2D


var gf_star =preload("res://Friends/GF.tscn")



var speed = 15
var jump_height =  -1500
var roll_speed = 15


onready var circle_sprite = preload("res://zip_zip/Players/Player_sprites/normal_circle.png")
onready var rect_sprite = preload("res://zip_zip/Players/Player_sprites/normal_rectangle.png")
onready var tri_sprite = preload("res://zip_zip/Players/Player_sprites/normal_triangle.png")

onready var sprite_list = [circle_sprite,rect_sprite,tri_sprite]

var current_sprite =  0




var color_1 = Color(0.937255, 0.278431, 0.435294)
var color_2 = Color(0.023529, 0.839216, 0.627451)
var color_3 = Color(1, 0.819608, 0.4)
var color_4 = Color(1, 1, 1)
var color_set = {0:color_1,1:color_2,2:color_3,3:color_4}
var current_color = 3



var shape_permission = 1
var color_permission = 3



var check_side_direction = false

var roll = false

export var invisible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if global.last_shape_permision !=null:
		shape_permission = global.last_shape_permision
	bounce = global.player_settings["Jump"]
	speed += global.player_settings["Speed"]
	
	
	for i in  range(3):
		if global.player_set[i] != null:
			sprite_list[i] = load("res://zip_zip/Players/Player_sprites/"+global.player_set[i]+".png")
			
			
	
	
	
	$Sprite.texture = sprite_list[current_sprite]
	modulate= color_set[current_color]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	gf_pos(delta)
	check_cast()
	if roll == true:
		$Sprite.rotation_degrees += 5
	if linear_velocity.x > 800:
		$Sprite.rotation_degrees += ((linear_velocity.x)/500)
		
		
		
		
func _on_RigidBody2D_body_entered(body):
	if body.is_in_group("Platform"):
		apply_central_impulse(Vector2(0,jump_height))
		#add_central_force(Vector2(0,-500))
		#angular_velocity = roll_speed
		#roll sprite
		$HitSound.play()
		roll= true
		$roll_time.start()



func _on_roll_time_timeout():
	roll = false
	
	
	
func damage(cod):#cause of death
	if invisible == false:
		if global.healt > 0:
			$AnimationPlayer.play("damage")
			if cod == "spike":
				global.healt -=1
			elif cod == "laser":
				global.healt -=2
				var dir = get_tree().current_scene.get_node("Fish_Boss").direction
				apply_central_impulse(Vector2(2000*-dir,0))
				
			else:
				global.healt -=global.healt

		if global.healt <= 0:
			global.game_over = true
			global.last_shape_permision = shape_permission
			if cod == "laser":
				speed = 0
				jump_height = 0
				roll_speed = 0
				$Dead_timer.start()
			elif cod == "spike":
				speed = 0
				jump_height = 0
				roll_speed = 0
				#angular_velocity = 0
				$Dead_timer.start()
			else:
				$Dead_timer.start()

		get_tree().current_scene.get_node("UI").check_health()
	
	
	
var gf = null
func add_gf():
	var new_gf = gf_star.instance()
	get_tree().current_scene.call_deferred("add_child",new_gf)
	new_gf.global_position = Vector2(global_position.x-100,global_position.y-100)
	gf = new_gf
	#new_gf.scale= Vector2(0.5,0.5)
	
func gf_pos(delta):
	if gf != null:
		gf.position = lerp(gf.position,position,delta)



func check_cast():
	var l = false
	var r = false
	var up  = false
	var down = false
	
	for cast in $cast_list.get_children():
		if cast.name == "down":
			if cast.is_colliding():
				down = true
			else:
				down = false
		if cast.name == "right":
			if cast.is_colliding():
				r = true
			else:
				r = false
		if cast.name == "up":
			if cast.is_colliding():
				up = true
			else:
				up = false
		if cast.name == "left":
			if cast.is_colliding():
				l = true
			else:
				l = false

	if l == false and r == false:
		check_side_direction = false
		jump_height =  -1200
		if Input.is_action_pressed("move_right"):
			apply_central_impulse(Vector2(10,0))
		elif Input.is_action_pressed("move_left"):
			apply_central_impulse(Vector2(-10,0))
		else:
			apply_central_impulse(Vector2(0,0))
		if global_position.y > 2500:
			if global.game_over == false:
				damage("fall_from_height")
				global.game_over = true
	elif l or r:
		check_side_direction = true
		jump_height =  0
		
		
		
		
		
func _on_Control1_swipe(move_vec,drag_value):
	
	
	if drag_value > 0 and move_vec.x > 0:
		apply_central_impulse(Vector2(round(move_vec.x)*-speed,0))
	elif drag_value >0 and move_vec.x < 0:
		apply_central_impulse(Vector2(round(move_vec.x)*speed,0))
	elif drag_value <0 and move_vec.x <0:
		apply_central_impulse(Vector2(round(move_vec.x)*-speed,0))
	elif drag_value <0 and move_vec.x >0:
		apply_central_impulse(Vector2(round(move_vec.x)*speed,0))
	




func _on_Control1_left():
	if check_side_direction == false:
		apply_central_impulse(Vector2(-speed,0))
	

func _on_Control1_right():
	if check_side_direction == false:
		apply_central_impulse(Vector2(speed,0))


func _on_Control1_click():
	current_sprite = (current_sprite + 1) % shape_permission #composite_frames.size()
	$Sprite.texture = sprite_list[current_sprite]
	
func _on_Control1_idle():
	
	apply_central_impulse(Vector2(0,0))


func _on_Dead_timer_timeout():
	global.save_data()
	var _restart = get_tree().reload_current_scene()



