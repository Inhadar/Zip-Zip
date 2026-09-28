extends Area2D



var shoot_direction = 1


func _physics_process(_delta):
	global_position.x +=  -shoot_direction * 20
	scale.x = -shoot_direction

