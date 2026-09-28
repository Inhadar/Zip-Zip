extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	$Sprite.rotation_degrees +=2


func _on_GFStar_body_entered(body):
	if body.is_in_group("Player"):
		$CPUParticles2D.emitting = true
		$Sprite.hide()
		$CollisionShape2D.set_deferred("disabled",true)
		$GFSound.play()
		get_tree().current_scene.get_node("Fish_Boss/Restore_timer").stop()
		get_tree().current_scene.get_node("Fish_Boss").start()
		get_tree().current_scene.get_node("Fish_Boss").move_permission = true
		get_tree().current_scene.get_node("Fish_Boss").stun = false
		
		
		yield(get_tree().create_timer(1),"timeout")
		body.add_gf()
		queue_free()
		
