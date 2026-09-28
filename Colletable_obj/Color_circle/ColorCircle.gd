extends Area2D

onready var Player = get_tree().current_scene.get_node("Player")
onready var spawner = get_tree().current_scene.get_node("Spawn_Tiles")
var color_1 = Color(0.937255, 0.278431, 0.435294)
var color_2 = Color(0.023529, 0.839216, 0.627451)
var color_3 = Color(1, 0.819608, 0.4)
var color_4 = Color(1, 1, 1)
var color_set = {0:color_1,1:color_2,2:color_3,3:color_4}

var color_range = 1

func _ready():
	$AnimationPlayer.play("New Anim")

func _physics_process(_delta:float)->void:
		#print(global_position.distance_to(Player.global_position))
	if global_position.distance_to(Player.global_position) > 2500 and global_position.x < Player.global_position.x:
		queue_free()
		spawner.color_spawn_count +=1
	


func _on_ColorCircle_body_entered(body):
	if body.is_in_group("Player"):
		var current_color_index
		while true:
			randomize()
			current_color_index = randi()%(color_range)
			if current_color_index != body.current_color:
				break
				
		body.modulate = color_set[current_color_index]
		global.player_color = color_set[current_color_index]
		body.current_color = current_color_index
		spawner.color_spawn_count += 1
		get_tree().current_scene.shock_wave()
		queue_free()
		
