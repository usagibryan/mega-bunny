extends Area2D

func _on_area_entered(area: Area2D) -> void:
	print("be was hit")
	area.queue_free()