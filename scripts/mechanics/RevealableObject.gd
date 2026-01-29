class_name RevealableObject extends Node3D

@export var inverse: bool = false 
# inverse = false: Objeto oculto que APARECE con el lente. (Debe estar en Capa 2)
# inverse = true: Objeto real que DESAPARECE con el lente. (Más complejo con capas, por ahora lo manejamos con visibilidad manual si es necesario, o usando Capa 1 y script)

func _ready() -> void:
	if inverse:
		# Para objetos inversos (obstáculos que desaparecen),
		# Mantener lógica antigua de señales es mejor porque "Capa que desaparece" no es standard.
		GLOBAL.connect("lens_toggled", Callable(self, "_on_lens_toggled_inverse"))
		_on_lens_toggled_inverse(GLOBAL.is_lens_active)
	else:
		# Para objetos ocultos normales:
		# Simplemente los movemos a la CAPA 2 (Capa de Lente).
		_set_layer_recursive(self, 2)

func _set_layer_recursive(node: Node, layer_bit: int) -> void:
	# Godot usa bitmasks. Capa 2 = Valor 2.
	
	if node is VisualInstance3D: # MeshInstance3D, etc.
		node.layers = layer_bit
		
	if node is CollisionObject3D: # StaticBody, Area, etc.
		node.collision_layer = layer_bit
		# node.collision_mask = layer_bit # Opcional, depende de con qué quiera chocar el objeto
		
	for child in node.get_children():
		_set_layer_recursive(child, layer_bit)

func _on_lens_toggled_inverse(active: bool) -> void:
	# Si el lente está activo, el objeto inverso se oculta.
	visible = !active
	
	# Desactivar colisiones
	_set_collision_disabled_recursive(self, active)

func _set_collision_disabled_recursive(node: Node, disabled: bool) -> void:
	if node is CollisionShape3D or node is CollisionPolygon3D:
		node.disabled = disabled
	
	for child in node.get_children():
		_set_collision_disabled_recursive(child, disabled)