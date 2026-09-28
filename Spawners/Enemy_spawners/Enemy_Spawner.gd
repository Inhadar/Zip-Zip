extends Node2D



#onready var tile1 = preload("res://Tiles/Tile1/Tile1.tscn")
export(PackedScene) var enemy1: PackedScene
export(PackedScene) var enemy2: PackedScene

onready var Player = get_tree().current_scene.get_node("Player")

var enemy_type = ""
var fly_enemy_mode = ""


var spawn_permision = false
var spawn_count = 1

#flying_enemy
#var LE = preload("res://Spawners/Enemy_spawners/Enemy_types/Line_enemy.tscn")
#var WE = preload("res://Spawners/Enemy_spawners/Enemy_types/Wave_enemy.tscn")
var distance_two_tiles = 1080



func _process(_delta:float)-> void:
	if spawn_count>0:
		if Player.global_position.y < 800:
			if global_position.distance_to(Player.global_position) < 3000 and global_position.x > Player.global_position.x:
				spawn()
	if global_position.distance_to(Player.global_position) < 1600 and global_position.x > Player.global_position.x:
		global_position.x += distance_two_tiles


func spawn():
	if spawn_permision:
		if enemy_type == "LE":
			var new_enemy = enemy1.instance()
			new_enemy.mode = fly_enemy_mode
			get_tree().current_scene.add_child(new_enemy)
			new_enemy.global_position = Vector2(global_position.x,Player.global_position.y)
			spawn_count -= 1
			global.enemy_count +=1
		if enemy_type == "WE":
			var new_enemy = enemy2.instance()
			new_enemy.mode = fly_enemy_mode
			get_tree().current_scene.add_child(new_enemy)
			new_enemy.global_position = Vector2(global_position.x,Player.global_position.y)
			spawn_count -= 1
			global.enemy_count +=1
