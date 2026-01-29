# Arquitectura: El Lente del Arrepentimiento

El sistema de "Lente del Arrepentimiento" permite al jugador alternar entre dos realidades: la Realidad Física y el Remordimiento.

## Sistema de Capas (Layers)

Para optimizar el rendimiento y evitar "espagueti" de código, utilizamos el sistema de **Cull Masks** y **Physics Layers** de Godot.

*   **Capa 1 (Realidad):** Objetos visibles y sólidos en todo momento.
*   **Capa 2 (Remordimiento):** Objetos que solo existen cuando el lente está activo.

### Funcionamiento Técnico

1.  **GLOBAL.gd (Autoload):** Actúa como el estado central. Emite la señal `lens_toggled(active: bool)` y gestiona la cordura (`sanity`).
2.  **Filberto (Player):** 
    *   Al activar el lente, cambia su `camera.cull_mask` para incluir la Capa 2.
    *   Cambia su `collision_mask` para poder colisionar con objetos en la Capa 2.
3.  **RevealableObject.gd:** Script utilitario que se coloca en objetos 3D. Al iniciar (`_ready`), mueve automáticamente el objeto a la Capa 2 (visual y física).

## Cordura (Sanity)

El uso del lente drena la cordura. Si llega a 0, el lente se desactiva por la fuerza y entra en un periodo de recuperación.
Los valores actuales son:
*   Drenaje: 15/seg.
*   Recuperación: 5/seg.
