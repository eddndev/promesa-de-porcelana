extends Node

# Señales Globales
signal lens_toggled(is_active: bool)
signal sanity_changed(new_value: float)

# Variables de Estado
var is_lens_active: bool = false
var sanity: float = 100.0
var max_sanity: float = 100.0

# Configuración
const SANITY_DRAIN_RATE: float = 15.0 # Cuanta cordura gasta por segundo
const SANITY_RECOVER_RATE: float = 5.0 # Cuanta recupera por segundo

func _process(delta: float) -> void:
	# Manejo de cordura
	if is_lens_active:
		sanity -= SANITY_DRAIN_RATE * delta
		if sanity <= 0:
			sanity = 0
			force_deactivate_lens()
	else:
		if sanity < max_sanity:
			sanity += SANITY_RECOVER_RATE * delta
			if sanity > max_sanity:
				sanity = max_sanity
	
	# Emitir cambio de cordura (útil para UI)
	# Nota: En un juego real optimizariamos para no emitir cada frame si no cambia mucho
	# pero para prototipo está bien.

func toggle_lens(active: bool) -> void:
	if active and sanity <= 0:
		return # No puede activar si no tiene cordura
		
	if is_lens_active != active:
		is_lens_active = active
		emit_signal("lens_toggled", is_lens_active)
		print("Lens active: ", is_lens_active)

func force_deactivate_lens() -> void:
	if is_lens_active:
		is_lens_active = false
		emit_signal("lens_toggled", false)
		print("Lens deactivated due to low sanity")