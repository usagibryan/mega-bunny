extends CharacterBody2D

var direction_x := 0.0
var facing_right := true
@export var speed = 150

var can_shoot := true
var has_gun := true

signal shoot(pos: Vector2, direction: bool)

func _process(_delta):
	get_input()
	apply_gravity()
	get_facing_direction()
	get_animation()
		
	velocity.x = direction_x * speed
	move_and_slide()
	
func get_input():
	direction_x = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -200
		
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot.emit(global_position, facing_right)
		can_shoot = false
		$Timers/CoolDown.start()
		
func apply_gravity():
	velocity.y += 20
	
func get_facing_direction():
	# only update if the player is moving
	if direction_x != 0:
		# if direction_x !>= 0 then facing_right will be false
		facing_right = direction_x >= 0
	
func get_animation():
		var animation = 'idle'
		if not is_on_floor():
			animation = 'jump'
		elif direction_x != 0:
			animation = 'walk'
		if has_gun:
			animation += '_gun'
		$AnimatedSprite2D.animation = animation
		$AnimatedSprite2D.flip_h = not facing_right
		
func _on_cool_down_timeout() -> void:
	can_shoot = true
