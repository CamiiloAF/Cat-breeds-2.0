# Cat breeds
Implementación de app de gatitos con propuesta de clean architecture.

## Versión de Flutter
Flutter 3.7.8 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 90c64ed42b • 2023-03-21 11:27:08 -0500
Engine • revision 9aa7816315
Tools • Dart 2.19.5 • DevTools 2.20.1

## Ejecutar proyecto
```
flutter run
```

## Estructura de archivos

    .
    ├── core                    # Archivos necesarios para que nuestra app funcione correctamente (http, local_storage, excepciones)
    ├── features                # Contiene cada una de las funcionalidades de la app
    │   ├─ folder_name          # Nombre del módulo
    │      ├── domain           # Contiene los archivos necesarios para la lógica de negocio, como casos de uso y entidades
    │      ├── data             # Contiene los archivos de la capa de datos, como repositories y data_sources
    │      ├── presentation     # Contiene todos los elementos de la UI del feature
    ├── providers               # Archivos necesarios para la implementación de patrones de manejo de estado alternativos a los BLoC
    └── shared                  # Contiene los elementos compartidos entre UI, como lo son el theme y el route handler