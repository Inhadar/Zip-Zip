extends Node


var scroll_time = 20.0

func _ready():
	$Scroll_Tween.interpolate_property($CanvasLayer/ScrollContainer,"scroll_vertical",0,$CanvasLayer/ScrollContainer/CenterContainer.rect_size.y,scroll_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Scroll_Tween.start()

func _on_Scroll_Tween_tween_all_completed():
	
	$AnimationPlayer.play("New Anim")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://UI/Main_menu.tscn")
