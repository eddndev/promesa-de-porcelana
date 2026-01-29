shader_type spatial;
render_mode skip_vertex_transform, diffuse_lambert_wrap, specular_disabled, ambient_light_disabled;

// Configuración PS1
uniform float jitter: hint_range(0.0, 1.0) = 0.5;
uniform float resolution_scale = 320.0; // Resolución virtual para el snapping

uniform sampler2D albedo_tex : filter_nearest; // Texturas pixeladas
uniform vec4 color : source_color = vec4(1.0);

void vertex() {
	// Transformación estándar a View Space
	vec4 vertex_pos = MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
	
	// Vertex Jitter (Snapping)
	// Convertimos a Clip Space
	vec4 clip_pos = PROJECTION_MATRIX * vertex_pos;
	
	// Dividimos por W para obtener coordenadas de pantalla normalizadas (NDC)
	vec3 ndc = clip_pos.xyz / clip_pos.w;
	
	// "Snap" a una rejilla virtual basada en la resolución
	float res_x = resolution_scale;
	float res_y = resolution_scale * (9.0 / 16.0); // Ajuste de aspecto aproximado
	
	ndc.x = floor(ndc.x * res_x) / res_x;
	ndc.y = floor(ndc.y * res_y) / res_y;
	
	// Reconstruimos la posición en Clip Space
	clip_pos.xyz = ndc * clip_pos.w;
	
	// Asignamos la posición final
	POSITION = clip_pos;
	
	// --- Affine Texture Mapping Emulation (Opcional, pero vital para PS1 real) ---
	// La PS1 no tenía corrección de perspectiva en texturas.
	// En Godot/OpenGL moderno es difícil desactivarlo completamente sin artifacts raros,
	// pero este shader básico ya dará el 90% del look con el Jitter.
}

void fragment() {
	vec4 tex = texture(albedo_tex, UV);
	ALBEDO = tex.rgb * color.rgb;
}
