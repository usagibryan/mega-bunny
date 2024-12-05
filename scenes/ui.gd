extends CanvasLayer

# get player as a variable
@onready var player = get_tree().get_first_node_in_group('Player')

func _process(_delta: float) -> void:
	$MarginContainer/ProgressBar.value = player.health
