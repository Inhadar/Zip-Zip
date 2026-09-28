extends KinematicBody2D



var velocity = Vector2.ZERO
var speed =  400
var rotation_speed = 1.5

var frequency = 1
var amplitude = 300

var time = 0

var mode = "wave"
var bee_mile = 100

var move_on = false
var round_on = true


#var one_permision = false
onready var spawner = get_tree().current_scene.get_node("Enemy_Spawner")
onready var Player = get_tree().current_scene.get_node("Player")

var line_sprite = preload("res://zip_zip/New_Style/Game_area/enemy_1.png") 
var wave_sprite = preload("res://zip_zip/New_Style/Game_area/enemy_2.png") 


		
func _physics_process(delta):
	
	if global_position.distance_to(Player.global_position) > 5000 and global_position.x < Player.global_position.x:
		queue_free()
		spawner.spawn_count +=1
		print("ensilindim")
	#if global_position.distance_to(spawner.global_position) > 600 and global_position.x < spawner.global_position.x:
	#	one_permision = false
	
	if mode == "wave":
		wave(delta)
	elif mode == "line":
		line(delta)
	velocity = move_and_slide(velocity,Vector2.UP)
	

#Function for round high coin numbers
func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)


func line(delta):
	frequency = 1
	amplitude = 1
	time+=delta
	var y_movement = cos(time*speed)*amplitude
	velocity.x = -speed
	velocity.y = y_movement


func wave(delta):
	$Sprite.rotation_degrees += 2
	frequency = 5
	amplitude = 1000
	time+=delta
	var y_movement = cos(time*frequency)*amplitude
	velocity.x = -speed
	velocity.y = y_movement
	


func _on_hit_area_body_entered(body):
	if body.name == "Player":
		body.damage("spike")
