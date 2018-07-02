extends KinematicBody

var motion = Vector3(0,0,0)
var MAXSPEED = 500
var SPEED= 50
var STOP = 50

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
		if !$character_spatial/character_animation.current_animation == "WalkAnim":
			$character_spatial/character_animation.play("WalkAnim")
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
		if !$character_spatial/character_animation.current_animation == "Idle":
			$character_spatial/character_animation.play("Idle")
	move_and_slide(motion*delta)
	print(motion)
	pass
