extends KinematicBody

var motion = Vector3(0,0,0)
var MAXSPEED = 50
var SPEED= 5
var STOP = 5

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	####################################################### z movement
	if Input.is_action_pressed("ui_up"):
		if motion.z > -MAXSPEED:
			motion.z -= SPEED
	else:
		if motion.z < -0:
			motion.z += STOP
	###############################
	if Input.is_action_pressed("ui_down"):
		if motion.z < MAXSPEED:
			motion.z += SPEED
	else:
		if motion.z > 0:
			motion.z -= STOP
	######################################################## x movement
	if Input.is_action_pressed("ui_left"):
		if motion.x > -MAXSPEED:
			motion.x -= SPEED
	else:
		if motion.x < 0:
			motion.x += STOP
	###############################
	if Input.is_action_pressed("ui_right"):
		if motion.x < MAXSPEED:
			motion.x += SPEED
	else:
		if motion.x > 0:
			motion.x -= STOP
	if motion.z>0:
		$character_sprites.play("run_down")
	if motion.z<0:
		$character_sprites.play("run_up")
	if motion.z == 0 and motion.x == 0:
		$character_sprites.play("idle_down")
	move_and_slide(motion*delta)
	print(motion)
	pass
