extends Area2D


onready var Player = get_tree().current_scene.get_node("Player")
export var trail_sprite = preload("res://zip_zip/Players/Player_sprites/normal_circle.png")


var x_speed = 20
var y_speed = 0


func _physics_process(_delta):

	var _direction = global_position.direction_to(Player.global_position)
	global_position.x += x_speed * -get_parent().get_node("Fish_Boss").direction
	global_position.y += y_speed
	$Sprite.rotation_degrees += 2
	#global_position.y = Player.global_position.y
	
	if global_position.distance_to(Player.global_position) > 2500 and global_position.x < Player.global_position.x:
		queue_free()




func _on_Area2D_body_entered(body):
	pass
	if body.name == "Player":
		body.damage("spike")


func _on_trail_timer_timeout():
	var new_sprite = Sprite.new()
	new_sprite.texture = trail_sprite
	#new_sprite.scale = Vector2(1,1)
	new_sprite.rotation_degrees = $Sprite.rotation_degrees
	get_tree().current_scene.add_child(new_sprite)
	new_sprite.global_position = global_position
	
	var new_tween = Tween.new()
	get_tree().current_scene.add_child(new_tween)
	new_tween.interpolate_property(new_sprite,"scale",scale,Vector2(0,0),2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	new_tween.start()
	var new_tween2 = Tween.new()
	get_tree().current_scene.add_child(new_tween2)
	new_tween2.interpolate_property(new_sprite,"modulate",Color(1, 1, 1, 1),Color(1, 1, 1, 0),2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	new_tween2.start()
	var new_tween3 = Tween.new()
	get_tree().current_scene.add_child(new_tween3)
	new_tween3.interpolate_property(new_sprite,"rotation_degrees",rotation_degrees,rotation_degrees+50,2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	new_tween3.start()
	
	
	new_tween2.connect("tween_all_completed",get_tree().current_scene,"Tween_sprite_deleter",[new_sprite,new_tween,new_tween2,new_tween3])
	
