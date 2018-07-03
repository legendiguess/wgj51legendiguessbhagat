extends KinematicBody

onready var motion = Vector3(0,0,0)
onready var MAXSPEED = 600
onready var SPEED= 50
onready var STOP = 50
onready var GRAVITY = 10
onready var FLOOR = Vector3(0, 1, 0)
onready var rot_target = 0
onready var rot_y = 0
onready var rot_speed = 10
var HP = 10


func _physics_process(delta):
	####################################################### z movement
	if Input.is_action_pressed("ui_up"):
		rot_target = 180
		walk_anim()
		if motion.z > -MAXSPEED:
			motion.z -= SPEED
	else:
		if motion.z < -0:
			motion.z += STOP
	###############################
	if Input.is_action_pressed("ui_down"):
		rot_target = 0
		walk_anim()
		if motion.z < MAXSPEED:
			motion.z += SPEED
	else:
		if motion.z > 0:
			motion.z -= STOP
	######################################################## x movement
	if Input.is_action_pressed("ui_left"):
		rot_target = 270
		walk_anim()
		if motion.x > -MAXSPEED:
			motion.x -= SPEED
	else:
		if motion.x < 0:
			motion.x += STOP
	###############################
	if Input.is_action_pressed("ui_right"):
		rot_target = 90
		walk_anim()
		if motion.x < MAXSPEED:
			motion.x += SPEED
	else:
		if motion.x > 0:
			motion.x -= STOP
	if motion.z == 0 and motion.x == 0:
		if !$character_spatial/character_animation.current_animation == "Idle":
			$character_spatial/character_animation.playback_speed = 1
			$character_spatial/character_animation.play("Idle")
	
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

