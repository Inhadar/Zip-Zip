extends Area2D


var phase_1 = preload("res://zip_zip/Boss/phase_1.png")
var phase_2 = preload("res://zip_zip/Boss/phase_2.png")
var phase_3 = preload("res://zip_zip/Boss/phase_3.png")
var phase_list = [phase_1,phase_2,phase_3]

export(PackedScene) var star: PackedScene
export(PackedScene) var WS: PackedScene #Weapon Shape
var Gfstar = preload("res://Friends/GFStar.tscn")#girl friend star
onready var Player = get_tree().current_scene.get_node("Player")


var current_phase = 1

var boss_pos
var star_direction = -1

var Boss_healt =3


var set_bos_new_y = false
var player_now_pos= Vector2()

var move_permission = false

var laser_is_active = false
var bull_is_attacking = false

var direction = -1
export var stun = false

export var screen_shake_perm = false

func _ready():
	move_permission = false
	$Sprite.texture = phase_list[current_phase-1]#load("res://zip_zip/Boss/phase_"+str(current_phase)+".png")
	#boss_pos = Player.global_position
	#new_boss_tween(boss_pos)
	if current_phase == 1:
		start()
	else:
		$Move_Anims.play("Idle")
		$Random_move.start()
		move_permission = true

func start():
	$Start_tween.interpolate_property(self,"global_position",global_position,Vector2(global_position.x-(800*direction),Player.global_position.y),Tween.EASE_IN_OUT,Tween.TRANS_QUAD)
	$Start_tween.start()
	$Move_Anims.play("Idle")
	$Random_move.start()


func _physics_process(delta):
	
	if scale.x > 0:
		direction = 1
	elif scale.x <0:
		direction  = -1
		
	if stun == false:
		if move_permission == true:
			player_now_pos = Player.global_position
			global_position.x = lerp(global_position.x,player_now_pos.x+(800*direction),delta*2)
			global_position.y = lerp(global_position.y,player_now_pos.y,delta/4)

		elif bull_is_attacking == true:
			global_position.x = lerp(global_position.x,player_now_pos.x+(2000*-direction),delta)
			var target_pos = Vector2(player_now_pos.x,player_now_pos.y)

			if global_position.distance_to(target_pos) > 1700:
				bull_is_attacking = false
				$Sprite/Head/CollisionShape2D.set_deferred("disabled",true)
				scale.x  *= -1

	if screen_shake_perm:
		get_tree().current_scene.screen_shake()
		screen_shake_perm = false


func New_timeout():
	if stun == false:
		move_permission = true
		$Move_Anims.play("Idle")
		$Random_move.start()

func create_timer(wait_time):
	var new_timer = Timer.new()
	add_child(new_timer)
	new_timer.one_shot = true
	new_timer.wait_time = wait_time
	new_timer.connect("timeout",self,"New_timeout")
	new_timer.start()

func new_ws_tween(pos,obj):
	var new_Tween = Tween.new()
	add_child(new_Tween)
	new_Tween.interpolate_property(obj,"global_position",Vector2(pos.x,pos.y),Vector2(pos.x+(400*-direction),pos.y),1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	new_Tween.start()
	new_Tween.connect("tween_all_completed",self,"new_ws_tween_finished",[new_Tween])
	
func new_ws_tween_finished(tween):
	tween.queue_free()


func spawn_WS():
	var new_ws = WS.instance()
	get_tree().current_scene.add_child(new_ws)
	new_ws.global_position = global_position
	new_ws_tween(global_position,new_ws)

func starshoot():
	var new_star = star.instance()
	get_tree().current_scene.add_child(new_star)
	new_star.global_position = $Sprite/star/Position2D.global_position
	$Boss_sound/Star_Shoot.play()
	#player_now_pos= Player.global_position
	#set_bos_new_y = true

func laugh():#starrain
	spawn_WS()
	get_tree().current_scene.star_rain()



func fish_rage():#starrain
	spawn_WS()
	get_tree().current_scene.rage_of_fish()



func laser():
	move_permission = false
	$Move_Anims.play("Laser")
	$Boss_sound/Laser.play()
	create_timer(8)

func bull():
	move_permission = false
	bull_is_attacking = true

func tongue():
	move_permission = false
	$Move_Anims.play("Tongue")
	create_timer(7)
	###################### <----------------- tongue sound
	
func new_boss_tween(pos):
	var new_Tween = Tween.new()
	new_Tween.interpolate_property(self,"global_position",Vector2(pos.x+1600,pos.y),Vector2(pos.x+700,pos.y),1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	add_child(new_Tween)
	new_Tween.start()
	
	new_Tween.connect("tween_all_completed",self,"new_boss_tween_finished",[new_Tween])
	
func new_boss_tween_finished(tween):
	tween.stop_all()
	$Random_move.start()
	check_phase()

func spawn_star(x,y,pos):
	var new_star = star.instance()
	new_star.x_speed = x
	new_star.y_speed = y
	get_tree().current_scene.add_child(new_star)
	new_star.global_position = pos


func check_phase():
	if stun == false:
		
		if current_phase == 1:
			randomize()
			var move_rate = randi()%2
			if move_rate == 0:
				$Move_Anims.play("Ready_star")
				attack_timer(5,"starshoot")
				$Boss_sound/RS_Charge.play()
			elif move_rate == 1:
				$Move_Anims.play("Laugh")
				attack_timer(1.5,"laugh")
				$Boss_sound/Laugh.play()
				
		if current_phase == 2:
			randomize()
			var move_rate =randi()%3
			if move_rate == 0:
				$Move_Anims.play("Laugh")
				attack_timer(1.5,"laugh")
				$Boss_sound/Laugh2.play()
				
			elif move_rate == 1:
				laser()
				
			elif move_rate == 2:
				$Move_Anims.play("Bull")
				attack_timer(2,"bull")
		
		if current_phase == 3:
			randomize()
			var move_rate = randi()%3
			if move_rate == 0:
				tongue()
				
				
			elif move_rate ==1:
				$Move_Anims.play("Fish_Rage")
				attack_timer(2,"fish_rage")
				###################### <----------------- fish rage sound
				
			elif move_rate  == 2:
				$Move_Anims.play("Bull")
				attack_timer(2,"bull")


func attack_timer(wait_time,attack_type):
	var at = Timer.new()
	add_child(at)
	at.one_shot = true
	at.wait_time = wait_time
	at.connect("timeout",self,"timeout_go_attack",[attack_type])
	at.start()
func timeout_go_attack(attack_type):
	if stun == false:
		if attack_type == "starshoot":
			for _i in range(1):
				starshoot()
				yield(get_tree().create_timer(0.5),"timeout")
		elif attack_type == "laugh":
			laugh()
		elif attack_type == "bull":
			bull()
		elif attack_type == "tongue":
			bull()
		elif attack_type == "fish_rage":
			fish_rage()
		yield(get_tree().create_timer(3),"timeout")
		bull_is_attacking = false
		move_permission = true
		$Move_Anims.play("Idle")
		$Random_move.start()


func create_gfstar():
	var new_gf = Gfstar.instance()
	new_gf.name = "Gf"
	get_tree().current_scene.call_deferred("add_child",new_gf)
	new_gf.global_position = $Sprite/star/Position2D.global_position
	new_gf_tween($Sprite/star/Position2D.global_position,new_gf)
	
	
	
	
func new_gf_tween(pos,obj):
	var gf_tween = Tween.new()
	add_child(gf_tween)
	var end_pos = Vector2(pos.x+(600*-direction),pos.y)
	gf_tween.interpolate_property(obj,"position",pos,end_pos,1,Tween.TRANS_LINEAR,Tween.EASE_OUT_IN)
	gf_tween.start()
	gf_tween.connect("tween_all_completed",self,"new_gf_tween_finished",[gf_tween])
	
	
	
func new_gf_tween_finished(tween):
	tween.queue_free()

func _on_Random_move_timeout():
	check_phase()



func _on_Fish_Boss_area_entered(area):
	if area.is_in_group("WSB"):
		area.get_node("Sprite").hide()
		area.get_node("trail").hide()
		area.get_node("exp").emitting = true
		Boss_healt -= 1
		get_tree().current_scene.screen_shake()
		$Boss_sound/StarExp.play()
		$Boss_sound/Hurt.play()
		$Boss_Personal_anim.play("damage")
		yield(get_tree().create_timer(0.55),"timeout")
		area.queue_free()
		
		if Boss_healt <= 0:
			if current_phase == 1:
				current_phase+=1
				get_tree().current_scene.flash()
				get_tree().current_scene.screen_shake()
				$Sprite.texture = phase_list[current_phase-1]#load("res://zip_zip/Boss/phase_"+str(current_phase)+".png")
				Boss_healt = 3
			elif current_phase ==2:
				move_permission = false
				stun = true
				$Move_Anims.stop()
				current_phase+=1
				$Sprite/Tongue.show()
				get_tree().current_scene.flash()
				get_tree().current_scene.screen_shake()
				$Sprite.texture = phase_list[current_phase-1]#load("res://zip_zip/Boss/phase_"+str(current_phase)+".png")
				$Sprite.hframes = 2#anim sayi cok olsa buna ehtiyac qalmir
				Boss_healt = 3
				create_gfstar()
				$Restore_timer.start()
				#ulduz düşsün
				#ulduz düşenden sonra timer başlasın
				#eger goturulmese yeniden faz iki olsun
				#goturulse playerin ustunde ucan minik ulduz gelsin
				#ve phase 3 olsun ve can resetlensin
			elif current_phase == 3:
				
				#cani bitince olum animasiyasi baslasin ve "The End(Demo)" yazsin ekranda
				#oyun bitdi
				#creditsler yazar var 5-10 saniye qalar ve ana menu qayidar
				stun = true
				$Random_move.stop()
				move_permission = false
				get_tree().current_scene.flash()
				get_tree().current_scene.screen_shake()
				
				########
				$Sprite.hide()
				$explosion.emitting = true
				$Boss_sound/Explosion.play()
				#$Move_Anims.play("Die_fish_die")
				#######
				
				
				$Sprite/Tongue_hitbox/CollisionShape2D.set_deferred("disabled",true)
				yield(get_tree().create_timer(3),"timeout")
				get_tree().current_scene.get_node("UI").the_end()
				queue_free()




func _on_Start_tween_tween_all_completed():
	move_permission = true
	$Start_tween.stop_all()



func _on_Restore_timer_timeout():
	current_phase-=1
	get_tree().current_scene.flash()
	get_tree().current_scene.screen_shake()
	$Sprite.texture = phase_list[current_phase-1]#load("res://zip_zip/Boss/phase_"+str(current_phase)+".png")
	$Sprite.hframes = 1
	$Sprite/Tongue.hide()
	Boss_healt = 1
	stun = false
	$Move_Anims.play("Idle")
	move_permission = true
	$Random_move.start()
	var gf_stars = get_tree().get_nodes_in_group("Gfstar")
	for i in gf_stars:
		i.queue_free()


func _on_Tongue_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		if body.linear_velocity.y>=1000:
			if current_phase == 3:
				if Boss_healt >1:
					Boss_healt -= 1
					get_tree().current_scene.screen_shake()
					print(current_phase)
					$Boss_Personal_anim.play("damage")
					$Move_Anims.play("Idle")
				else:
					stun = true
					$Random_move.stop()
					###
					$Sprite.hide()
					$explosion.emitting = true
					$Boss_sound/Explosion.play()
					#$Move_Anims.play("Die_fish_die")
					###
					$Sprite/Tongue_hitbox/CollisionShape2D.set_deferred("disabled",true)
					yield(get_tree().create_timer(3),"timeout")
					get_tree().current_scene.get_node("UI").the_end()
					queue_free()
				
				#cani bitince olum animasiyasi baslasin ve "The End(Demo)" yazsin ekranda
				#oyun bitdi
				#creditsler yazar var 5-10 saniye qalar ve ana menu qayidar



func _on_Head_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().current_scene.screen_shake()
		body.damage("laser")
		$Sprite/Head/CollisionShape2D.set_deferred("disabled",true)


func _on_Tongue_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().current_scene.screen_shake()
		body.damage("laser")


func _on_Laser_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().current_scene.screen_shake()
		body.damage("laser")
