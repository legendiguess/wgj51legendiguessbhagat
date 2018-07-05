extends KinematicBody

var HP = 10

func _ready():
	$"Scene Root/AnimationPlayer".play("default")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
