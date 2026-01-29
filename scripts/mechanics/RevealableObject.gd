class_name RevealableObject extends Node3D

@export var inverse: bool = false # Si es true, desaparece al usar el lente.
@onready var visual_mesh: MeshInstance3D = null
@onready var collider: CollisionShape3D = null

func _ready() -> void:
	# Intentar encontrar hijos comunes automáticamente si no se asignan manualmente
	# Esto facilita el level design: Solo arrastras el script al nodo padre.
	for child in get_children():
		if child is MeshInstance3D:
			visual_mesh = child
		elif child is CollisionShape3D:
			collider = child
		elif child is StaticBody3D:
			# Si el script está en la raíz y la colisión está adentro
			for subchild in child.get_children():
				if subchild is CollisionShape3D:
					collider = subchild
			
	
	# Conectar a la señal global
	GLOBAL.connect("lens_toggled", Callable(self, "_on_lens_toggled"))
	
	# Estado inicial
	_update_state(GLOBAL.is_lens_active)

func _on_lens_toggled(active: bool) -> void:
	_update_state(active)

func _update_state(lens_active: bool) -> void:
	var should_be_visible = lens_active
	
	if inverse:
		should_be_visible = !lens_active
		
	# Aplicar visibilidad
	if visual_mesh:
		visual_mesh.visible = should_be_visible
	else:
		visible = should_be_visible # Fallback: ocultar todo el nodo
		
	# Aplicar colisión
	if collider:
		collider.disabled = !should_be_visible
