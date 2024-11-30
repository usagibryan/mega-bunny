extends Area2D

var direction := 1
@export var speed := 300

func _ready():
	# make the bullet face the correct direction
	$Sprite2D.flip_h = direction < 0

func _process(delta):
	# control the movement of the bullet
	position.x += speed * direction * delta
