extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$heart_animation_player.play("idle")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_heart_area_body_entered(body):
	if body.get_name() == "character":
		body.HP += 20
		queue_free()
	pass # replace with function body
