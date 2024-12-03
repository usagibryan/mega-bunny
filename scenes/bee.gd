extends Area2D

var health := 3

func _on_area_entered(area: Area2D) -> void:
	health -= 1
	area.queue_free()

func _process(_delta):
	check_death()
	
func check_death():
	if health <= 0:
		queue_free()
