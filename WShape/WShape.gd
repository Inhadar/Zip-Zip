extends Area2D
#extends RigidBody2D



export(PackedScene) var WSB: PackedScene #Weapon Shape Bullet


func _ready():
	$Sprite.frame= randi()%3
	#var boss_dir = get_tree().current_scene.get_node("Fish_Boss").direction
	#apply_central_impulse(Vector2(500*-boss_dir,-500))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func shoot_bullet():
	var new_shoot = WSB.instance()
	new_shoot.shoot_direction = -get_tree().current_scene.get_node("Fish_Boss").direction
	get_tree().current_scene.call_deferred("add_child",new_shoot)
	new_shoot.global_position = global_position
	
	


func _on_WShape_body_entered(body):
	if  body.name == "Player":
		if body.current_sprite == $Sprite.frame:
			shoot_bullet()
			$WShoot.play()
			$Sound_delete_timer.start()
			$CollisionShape2D.set_deferred("disabled",true)
			hide()



func _on_Delete_timer_timeout():
	queue_free()


func _on_Sound_delete_timer_timeout():
	pass # Replace with function body.
