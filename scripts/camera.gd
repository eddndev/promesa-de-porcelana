extends Camera3D

# Variables

@export var mouse_sensibility : float = 0.005

# Funciones

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # Aqui se pone para que desaparezca el puntero

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: 
		# El jugador (get_parent) rotara segun el movimiento del mouse y se regulara con la sensibilidad
		get_parent().rotate_y(-event.relative.x * mouse_sensibility)
		# Aqui se rota la propia camara
		rotate_x(-event.relative.y * mouse_sensibility)
		rotation.x = clamp(rotation.x, deg_to_rad(-80), deg_to_rad(80)) # Los valores de 80 indican hasta cuanto rotar
