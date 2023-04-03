# Cat breeds
Implementación de app de gatitos el arquetipo de Flutter - Pragma.

## Versión de Flutter
Flutter 3.7.8 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 90c64ed42b • 2023-03-21 11:27:08 -0500
Engine • revision 9aa7816315
Tools • Dart 2.19.5 • DevTools 2.20.1

## Ejecutar proyecto
```
flutter run
```

## Estructura de paquetes
    .
    ├── blocs                   # Archivos que implementan la clase BlocModule
    ├── core                    # Archivos necesarios para que nuestra app funcione correctamente (http, local_storage)
    ├── entities                # Entidades de la app  
    ├── exceptions              # Excepciones del proyecto
    ├── modules                 # Contiene cada una de las funcionalidades de la app
    │   ├─ folder_name          # Nombre del módulo
    │      ├── blocs            # Blocs de cada módulo
    │      ├── models           # Clases de datos del módulo
    │      ├── ui               # Contiene todos los elementos de la UI del módulo
    ├── providers               # Archivos necesarios para la implementación de patrones de manejo de estado alternativos a los BLoC
    └── services                # Archivos necesarios para la comunicación con servicios externos