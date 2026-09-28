extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Boss_gate_body_entered(body):
	if body.is_in_group("Player"):
		if global.score >=32768:# and global.score < 81380:
			var _goto_boss_1 = get_tree().change_scene("res://Levels/Boss_1/Boss_1.tscn")
