extends CharacterBody2D

var direction_x := 0.0
var facing_right := true
@export var speed = 150

var can_shoot := true
var has_gun := false
var vulnerable := true

signal shoot(pos: Vector2, direction: bool)

var health := 100

func _process(_delta):
	get_input()
	apply_gravity()
	get_facing_direction()
	get_animation()
		
	velocity.x = direction_x * speed
	move_and_slide()
	check_death()
	
func get_input():
	direction_x = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -250
		$Sounds/JumpSound.play()
		
	if Input.is_action_just_pressed("shoot") and can_shoot and has_gun:
		shoot.emit(global_position, facing_right)
		can_shoot = false
		$Timers/CoolDown.start()
		$Timers/FireTimer.start()
		# FireLeft and FireRight are accessed by indexes 0 an 1
		$Fire.get_child((facing_right)).show()
		$Sounds/FireSound.play()
		
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

func _on_fire_timer_timeout() -> void:
	for child in $Fire.get_children():
		child.hide()
		
func get_damage(amount):
	if vulnerable:
		health -= amount
		print(health)
		var tween = create_tween()
		tween.tween_property($AnimatedSprite2D, "material:shader_parameter/amount", 1.0, 0.0)
		tween.tween_property($AnimatedSprite2D, "material:shader_parameter/amount", 0.0, 0.1).set_delay(0.2)
		vulnerable = false
		$Timers/InvincibilityTimer.start()
		$Sounds/DamageSound.play()

func _on_invincibility_timer_timeout() -> void:
	vulnerable = true

func check_death():
	if health <= 0:
		get_tree().quit()
