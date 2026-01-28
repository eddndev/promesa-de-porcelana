class_name Filberto extends CharacterBody3D

# Variables de movimiento

@export_category("Movimiento")
@export var speed : float = 425.0
@export var gravity : float = 84.0
@export var jump_force : float = 1250.0

# Variables

@export_category("Fixes")
@export var coyote_time : float = .02
var can_jump : bool = false

# Nodos

@onready var camera : Camera3D = $Camera3D
@onready var coyote : Timer = $Coyote

# Funciones

func get_axis() -> Vector2: # Devolvera una direccion de vector dependiendo de las teclas presionadas
	var axis : Vector2 = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("derecha")) - int(Input.is_action_pressed("izquierda"))
	axis.y = int(Input.is_action_pressed("atras")) - int(Input.is_action_pressed("adelante"))
	return axis

func move_crtl(delta : float) -> void:
	# Se calcula una direccion relativa para donde se rote el jugador
	var direction = (transform.basis * Vector3(get_axis().x, 0, get_axis().y)).normalized() 
	if Input.is_action_pressed("sigilo"):
		direction /= 3.0
	# Se aplican las fuerzas a los lados
	velocity.x = direction.x * speed * delta
	velocity.z = direction.z * speed * delta
	# Se aplica gravedad cuando no se esta en el suelo
	if !is_on_floor():
		velocity.y += -gravity * delta
	move_and_slide()

func jump(delta : float) -> void: # Funcion de salto
	if is_on_floor(): can_jump = true # Permitir salto
	elif !is_on_floor() and can_jump:
		coyote.start(coyote_time)
	if Input.is_action_pressed("saltar") and can_jump:
		can_jump = false
		velocity.y = jump_force * delta

func _process(delta : float) -> void:
	move_crtl(delta)
	jump(delta)

func _input(_event: InputEvent) -> void:
	# Cuando ya no se presiona espacio se divide la velocidad para regular el salto
	if Input.is_action_just_released("saltar") and velocity.y > 0:
		velocity.y /= 5
	# Para ir mas lento


"""
Para Edd:
Ya que vas a realizar un calculo para que los FPS a los que corre el juego sean los mismos que permita
el computador del usuario, ten en cuenta la funcion procces y su parametro delta el cual pasaras a las
funciones correspondientes y multiplicaras por este cada que afecte a una fisica especifica.

delta = tiempo de cambio entre frame

exite otra funcion que es _physics_process(delta) que siempre seran 60 fps (configurable)

"""


func _on_coyote_timeout() -> void:
	can_jump = false
