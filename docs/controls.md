# Controles y Físicas

## Mapeo de Teclas

| Acción | Tecla / Botón |
| :--- | :--- |
| Movimiento | W, A, S, D |
| Salto | Espacio |
| Sigilo | Shift |
| **Lente** | **Click Derecho (Hold)** |
| Interactuar | E (Pendiente) |

## Detalles de Implementación

### Físicas del Jugador
El movimiento se procesa en `_physics_process` para asegurar consistencia independientemente de los FPS.
*   **Velocidad:** 5.0 m/s
*   **Gravedad:** 20.0 m/s² (Caída pesada y dramática)
*   **Fuerza de Salto:** 9.0 (Salto variable: si sueltas Espacio antes, saltas menos).

### Coyote Time
El jugador tiene un margen de **0.15 segundos** para saltar después de haber dejado de tocar el suelo, facilitando el plataformeo en los bordes de los escombros.
