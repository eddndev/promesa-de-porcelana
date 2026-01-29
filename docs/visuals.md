# Guía Estética: Estilo PS1

El proyecto utiliza una combinación de técnicas de post-procesado y shaders de material para lograr el look de la era de 32 bits.

## 1. Post-Procesado (Pantalla)
Ubicación: `main/ps1_filter.tscn` (Shader: `test/PS1.gdshader`)

Este filtro se aplica sobre toda la pantalla y realiza las siguientes tareas:
*   **Posterización:** Reduce la profundidad de color (14 niveles por defecto).
*   **Aberración Cromática:** Desplaza los canales R y B en los bordes.
*   **Downsampling:** Simula una resolución baja.
*   **Brightness/Saturation:** Ajusta el tono para ese look "lavado" pero contrastado.

## 2. Vertex Jitter (Modelos)
Ubicación: `assets/shaders/ps1_jitter.gdshader`

Para emular la falta de precisión de punto flotante de la PS1, se debe aplicar este shader a los materiales de los objetos 3D.
*   **Snapping:** Los vértices se redondean a una rejilla de píxeles virtual.
*   **Configuración:** Se puede ajustar la intensidad del `jitter` y la `resolution_scale` en los parámetros del material.

## 3. Texturizado
*   **Filtro:** Las texturas deben configurarse con **Filter: Nearest** (sin suavizado).
*   **Resolución:** Se recomienda usar texturas de 64x64, 128x128 o máximo 256x256.
