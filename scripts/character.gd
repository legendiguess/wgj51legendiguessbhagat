extends KinematicBody

var motion = Vector3(0,0,0)
var MAXSPEED = 350
var SPEED= 35
var HP = 100
var ROT = 0.0

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
			motion.z += SPEED
	###############################
	if Input.is_action_pressed("ui_down"):
		HP -=1
		if !$character_spatial/character_animation.current_animation == "WalkAnim":
			$character_spatial/character_animation.play("WalkAnim")
		if motion.z < MAXSPEED:
			motion.z += SPEED
	else:
		if motion.z > 0:
			motion.z -= SPEED
	######################################################## x movement
	if Input.is_action_pressed("ui_left"):
		if motion.x > -MAXSPEED:
			motion.x -= SPEED
	else:
		if motion.x < -0:
			motion.x += SPEED
	###############################
	if Input.is_action_pressed("ui_right"):
		if motion.x < MAXSPEED:
			motion.x += SPEED
	else:
		if motion.x > 0:
			motion.x -= SPEED
	
	if motion.z>0:
		$character_sprites.play("run_down")
	if motion.z<0:
		$character_sprites.play("run_up")
	if motion.z == 0 and motion.x == 0:
		if !$character_spatial/character_animation.current_animation == "Idle":
			$character_spatial/character_animation.play("Idle")
	motion = motion.rotated(Vector3(0, 1, 0), ROT)
	move_and_slide(motion*delta, Vector3(0, 0, 1))
	get_node("../gui/health_bar").value = HP
	print(motion)
	pass
