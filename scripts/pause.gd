extends CanvasLayer

# Funciones

func _ready() -> void:
	layer = -2 # Para que las demas capas no interfieran con esta
	hide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = not get_tree().paused # Pausar el juego
		match get_tree().paused: # Definir mostrar/ocultar el menu
			true: show(); layer = 3; Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			false: hide(); layer = -3; Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
