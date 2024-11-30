extends Area2D

func _process(delta):
	# make the gun float up and down, with extra math to control speed
	position.y += sin(Time.get_ticks_msec() / 200.0) * 10 * delta

func _on_body_entered(body: Node2D) -> void:
	body.has_gun = true
	queue_free()
