extends KinematicBody

onready var motion = Vector3(0,0,0)
onready var MAXSPEED = 600
onready var SPEED= 500
onready var STOP = 50
onready var GRAVITY = 10
onready var FLOOR = Vector3(0, 1, 0)
onready var rot_target = 0
onready var rot_y = 0
onready var rot_speed = 10
var HP = 100


func _physics_process(delta):
	####################################################### z movement
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right") and $character_spatial/character_animation.current_animation != "Attack":
		rot_target = 135
		walk_anim()
		motion.z = -SPEED/1.5
		motion.x = SPEED/1.5
	elif Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left") and $character_spatial/character_animation.current_animation != "Attack":
		rot_target = 225
		walk_anim()
		motion.z = -SPEED/1.5
		motion.x = -SPEED/1.5
	elif Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right") and $character_spatial/character_animation.current_animation != "Attack":
		rot_target = 35
		walk_anim()
		motion.z = SPEED/1.5
		motion.x = SPEED/1.5
	elif Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left") and $character_spatial/character_animation.current_animation != "Attack":
		rot_target = 325
		walk_anim()
		motion.z = SPEED/1.5
		motion.x = -SPEED/1.5
	elif Input.is_action_pressed("ui_up") and $character_spatial/character_animation.current_animation != "Attack":
		motion.x = 0
		rot_target = 180
		walk_anim()
		motion.z = -SPEED
	###############################
	elif Input.is_action_pressed("ui_down") and $character_spatial/character_animation.current_animation != "Attack":
		motion.x = 0
		rot_target = 0
		walk_anim()
		motion.z = SPEED
	######################################################## x movement
	elif Input.is_action_pressed("ui_left") and $character_spatial/character_animation.current_animation != "Attack":
		motion.z = 0
		rot_target = 270
		walk_anim()
		motion.x = -SPEED
	###############################
	elif Input.is_action_pressed("ui_right") and $character_spatial/character_animation.current_animation != "Attack":
		motion.z = 0
		rot_target = 90
		walk_anim()
		motion.x = SPEED
	else:
		motion.z = 0
		motion.x = 0
	
	if motion.z == 0 and motion.x == 0:
		if !$character_spatial/character_animation.current_animation == "Idle" and $character_spatial/character_animation.current_animation != "Attack":
			$character_spatial/character_animation.playback_speed = 1
			$character_spatial/character_animation.play("Idle")
	
	if Input.is_action_just_pressed("ui_accept") and $character_spatial/character_animation.current_animation != "Attack":
		$character_spatial/character_animation.play("Attack")
	
	if not is_on_floor():
		motion.y -= GRAVITY
	else:
		motion.y = 0
	
	rotate_mesh()
	
	move_and_slide(motion*delta, FLOOR)
#	print(motion)

func walk_anim():
	if $character_spatial/character_animation.current_animation != "WalkAnim":
		$character_spatial/character_animation.playback_speed = 3
		$character_spatial/character_animation.play("WalkAnim")

func rotate_mesh():
	
	if rot_y > 360:
		rot_y = 0
	elif rot_y < 0:
		rot_y = 360
	
	if rot_y < (rot_target):
		if (rot_target - rot_y) <= 180:
			rot_y += rot_speed
		else:
			rot_y -= rot_speed
	elif rot_y > (rot_target):
		if (rot_y - rot_target) >= 180:
			rot_y += rot_speed
		else:
			rot_y -= rot_speed
	
	$character_spatial/Skeleton.rotation_degrees.y = rot_y



func _on_character_area_body_entered(body):
	if body.is_in_group("enemys"):
		HP -=10
		$character_spatial/character_animation_2.play("hit")
		if rot_target == 180:
			translation.z +=150*get_process_delta_time()
		if rot_target == 0:
			translation.z -=150*get_process_delta_time()
		if rot_target == 270:
			translation.x +=150*get_process_delta_time()
		if rot_target == 90:
			translation.x -=150*get_process_delta_time()
		translation.y += 50*get_process_delta_time()
	pass # replace with function body


func _on_sword_area_body_entered(body):
	if body.is_in_group("enemys") and $character_spatial/Skeleton/sword.visible == true:
		body.HP -= 10
		if body.HP == 0 or body.HP < 0:
			body.queue_free()
	pass # replace with function body
