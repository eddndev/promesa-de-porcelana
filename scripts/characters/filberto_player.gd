class_name Filberto extends CharacterBody3D

# Variables de movimiento

@export_category("Movimiento")
@export var speed : float = 5.0
@export var gravity : float = 20.0
@export var jump_force : float = 9.0

# Variables

@export_category("Fixes")
@export var coyote_time : float = 0.15
var can_jump : bool = false

# Nodos

@onready var camera : Camera3D = $Camera3D
@onready var coyote : Timer = $Coyote

# Funciones

func get_axis() -> Vector2:
	var axis : Vector2 = Vector2.ZERO
	axis.x = Input.get_axis("izquierda", "derecha")
	axis.y = Input.get_axis("adelante", "atras")
	return axis

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Coyote Time y Estado de Salto
	if is_on_floor():
		can_jump = true
		coyote.stop()
	elif can_jump and coyote.is_stopped():
		coyote.start(coyote_time)

	# Salto
	if Input.is_action_just_pressed("saltar") and can_jump:
		velocity.y = jump_force
		can_jump = false
	
	# Salto Variable (soltar botón reduce altura)
	if Input.is_action_just_released("saltar") and velocity.y > 0:
		velocity.y *= 0.5

	# Lente del Arrepentimiento
	if Input.is_action_pressed("lente"):
		GLOBAL.toggle_lens(true)
	else:
		GLOBAL.toggle_lens(false)

	# Movimiento
	var input_dir = get_axis()
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var current_speed = speed
	if Input.is_action_pressed("sigilo"):
		current_speed /= 3.0

	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()

func _on_coyote_timeout() -> void:
	can_jump = false
