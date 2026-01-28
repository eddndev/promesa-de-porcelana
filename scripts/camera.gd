extends Camera3D

# Variables

@export var mouse_sensibility : float = 0.005

# Objetos

@onready var raycast : RayCast3D = $RayCast3D

# Funciones

func interact() -> void:
	# Aqui se programara el comportamiendo de un raycast para interactuar con objetos
	if raycast.is_colliding():
		var object = raycast.get_collider()
		# if object is interactuar:
		print(object.name)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # Aqui se pone para que desaparezca el puntero

func _process(_delta: float) -> void:
	#interact()
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: 
		# El jugador (get_parent) rotara segun el movimiento del mouse y se regulara con la sensibilidad
		get_parent().rotate_y(-event.relative.x * mouse_sensibility)
		# Aqui se rota la propia camara
		rotate_x(-event.relative.y * mouse_sensibility)
		rotation.x = clamp(rotation.x, deg_to_rad(-80), deg_to_rad(80)) # Los valores de 80 indican hasta cuanto rotar
