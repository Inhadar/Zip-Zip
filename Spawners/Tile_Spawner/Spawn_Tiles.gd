extends Node2D



var boss_gate = preload("res://Gates/Boss_gate.tscn")
var spawned_gate = false
#onready var tile1 = preload("res://Tiles/Tile1/Tile1.tscn")
export(PackedScene) var tile1: PackedScene
export(PackedScene) var color_circle: PackedScene

onready var Player = get_tree().current_scene.get_node("Player")
var tile_spawn_count = 10
var color_spawn_count = 3
var dtt = 600 #distance_two_tiles
var shr = 50 #spawn_height_rate
var ccr = 1 #circle_color_range
var circle_spawn_perm = false


func _process(_delta:float)-> void:
	if tile_spawn_count>0:
		spawn_tile()
	if color_spawn_count>0:
		spawn_cc()

		
func spawn_tile():
	var tile_instance = tile1.instance()
	get_tree().current_scene.add_child(tile_instance)
	tile_instance.position.y = global_position.y + rand_range(-shr,shr)
	tile_instance.position.x = global_position.x
	global_position.x += dtt
	
	if global.score >= 32768:# and global.score < 81920:
		if tile_spawn_count == 1:
			if spawned_gate == false:
				spawn_gate(tile_instance.global_position)
				spawned_gate = true
	else:
		pass
		
	tile_spawn_count-=1
	global.all_tiles +=1 
	
	

func spawn_cc():
	if circle_spawn_perm:
		randomize()
		var spawn_rate = randi()%100
		if spawn_rate in range(1):
			var new_circle = color_circle.instance()
			new_circle.color_range = ccr
			get_tree().current_scene.add_child(new_circle)
			new_circle.global_position.x = global_position.x - (dtt/2)
			#new_circle.global_position.y = global_position.y -500
			color_spawn_count -=1
			
			
			
func spawn_gate(pos):
	var new_gate = boss_gate.instance()
	get_tree().current_scene.add_child(new_gate)
	new_gate.global_position = pos
	new_gate.global_position.y -=1600
	
